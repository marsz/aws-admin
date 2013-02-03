class Ec2Snapshot < ActiveRecord::Base
  validates_presence_of :snapshot_id
  validates_uniqueness_of :snapshot_id
  belongs_to :instance, :class_name => "Ec2Instance", :foreign_key => :ec2_instance_id
  after_destroy :destroy_from_aws

  private

  def destroy_from_aws
    AwsEc2.new.destroy_snapshot(snapshot_id)
  end

end
