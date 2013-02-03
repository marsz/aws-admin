class Ec2Instance < ActiveRecord::Base
  validates_presence_of :instance_id
  validates_uniqueness_of :instance_id
  include Backupable

end
