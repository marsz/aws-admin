module Backupable
  extend ActiveSupport::Concern

  included do
    send :backupable
  end

  module ClassMethods

    def picks_to_backup
      self.scoped.each do |model|
        begin
          model.backup
        rescue
        end
      end
    end

    private 

    def backupable
      has_many :snapshots, :class_name => "Ec2Snapshot", :foreign_key => "#{self.to_s.underscore}_id", :dependent => :delete_all
    end

  end

  module InstanceMethods

    def backup(force = false)
      if force || last_backup_at.nil? || (Time.now - last_backup_at > interval_days.days)
        if create_snapshot
          rotate_snapshots
        end
      end
    end

    def create_snapshot
      if hash = AwsEc2.new.create_snapshot(id_column_name.to_sym => self.send(id_column_name))
        update_column :last_backup_at, Time.now
        snapshots.create!(hash)
      end
    end

    def rotate_snapshots
      if rotate_count > 0 && snapshots.size > rotate_count
        snapshots.order("id DESC")[(rotate_count - snapshots.size)..-1].each do |snapshot|
          snapshot.destroy
        end
      end
    end

    private

    def id_column_name
      self.class.to_s.underscore.gsub("ec2_", "") + "_id"
    end

  end

end