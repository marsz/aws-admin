class AddColumnEc2VolumeIdToSnapshots < ActiveRecord::Migration
  def change
    add_column :ec2_snapshots, :ec2_volume_id, :integer, :after => :ec2_instance_id
    add_index :ec2_snapshots, [:ec2_volume_id]
  end
end
