class CreateEc2Volumes < ActiveRecord::Migration
  def change
    create_table :ec2_volumes do |t|
      t.string :volume_id
      t.string :description
      t.integer :rotate_count, :default => 5
      t.integer :interval_days, :default => 3
      t.datetime :last_backup_at
      t.timestamps
    end
    add_index :ec2_volumes, [:volume_id]
  end
end
