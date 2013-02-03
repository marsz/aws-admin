module ApplicationHelper

  def render_ec2_instance_name(ec2_instance)
    if ec2_instance.description.present?
      "#{ec2_instance.description} (#{ec2_instance.instance_id})"
    else
      "#{ec2_instance.instance_id}"
    end
  end

  def render_ec2_volume_name(ec2_volume)
    if ec2_volume.description.present?
      "#{ec2_volume.description} (#{ec2_volume.volume_id})"
    else
      "#{ec2_volume.volume_id}"
    end
  end

end
