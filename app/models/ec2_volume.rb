class Ec2Volume < ActiveRecord::Base
  validates_presence_of :volume_id
  validates_uniqueness_of :volume_id
  include Backupable
end
