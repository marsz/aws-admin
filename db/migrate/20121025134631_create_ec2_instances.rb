class CreateEc2Instances < ActiveRecord::Migration
  def change
    create_table :ec2_instances do |t|
      t.string :instance_id
      t.string :description
      t.integer :rotate_count, :default => 5
      t.integer :interval_days, :default => 3
      t.datetime :last_backup_at
      t.timestamps
    end
    add_index :ec2_instances, [:instance_id], :unique => true
  end
end
