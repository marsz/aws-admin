class CreateEc2Snapshots < ActiveRecord::Migration
  def change
    create_table :ec2_snapshots do |t|
      t.string :snapshot_id
      t.string :description
      t.string :volume_id
      t.integer :ec2_instance_id
      t.timestamps
    end
    add_index :ec2_snapshots, [:snapshot_id], :unique => true
    add_index :ec2_snapshots, [:volume_id]
    add_index :ec2_snapshots, [:ec2_instance_id]
  end
end