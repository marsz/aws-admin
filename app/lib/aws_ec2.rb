class AwsEc2
  PREFIX = "auto_backup"

  def create_snapshot(options = {})
    vol_id = options[:volume_id] || find_volume_id_by_instance_id(options[:instance_id])
    desc = options[:description] || generate_snapshot_description(options)
    snapshot = ec2.snapshots.create(:volume_id => vol_id, :description => desc)
    snapshot_to_hash(snapshot)
  end

  def destroy_snapshot(snapshot_id)
    ec2.snapshots[snapshot_id].delete
  end

  private

  def find_volume_id_by_instance_id(instance_id)
    if instance = ec2.instances[instance_id]
      instance.block_device_mappings["/dev/sda1"].volume.id
    end
  end

  def generate_snapshot_description(options = {})
    desc = fetch_instance_name(options[:instance_id]).to_s + (options[:volume_id] ? "_#{options[:volume_id]}" : "")
    "#{AwsEc2::PREFIX}-#{desc}-#{Time.now.to_i}"
  end

  def fetch_instance_name(instance_id)
    ec2.instances[instance_id].tags["Name"] || instance_id
  end

  def ec2
    @ec2 = AWS::EC2.new.regions[config[:region]] if !@ec2
    @ec2
  end

  def config
    Setting.aws
  end

  def snapshot_to_hash(snapshot)
    {:snapshot_id => snapshot.id, :volume_id => snapshot.volume_id, :description => snapshot.description}
  end
end