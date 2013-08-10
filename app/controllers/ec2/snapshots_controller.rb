class Ec2::SnapshotsController < ApplicationController
  before_filter :get_parent
  load_and_authorize_resource :ec2_snapshot

  def index
    @ec2_snapshots = @ec2_parent.snapshots

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @ec2_snapshots }
    end
  end

  def create
    respond_to do |format|
      redirect_url = send("ec2_#{@parent}_snapshots_path", @ec2_parent)
      if @ec2_snapshot = @ec2_parent.create_snapshot
        @ec2_parent.rotate_snapshots
        format.html { redirect_to redirect_url, :notice => 'Snapshot was successfully created.' }
        format.json { render :json => @ec2_snapshot, :status => :created, :location => redirect_url }
      else
        format.html { redirect_to redirect_url, :error => 'Snapshot was not created.' }
        format.json { render json: @ec2_parent.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @ec2_snapshot = @ec2_parent.snapshots.find params[:id]
    @ec2_snapshot.destroy if @ec2_snapshot

    respond_to do |format|
      format.html { redirect_to send("ec2_#{@parent}_snapshots_path", @ec2_parent) }
      format.json { head :no_content }
    end
  end

  private

  def get_parent
    if params[:instance_id]
      @ec2_parent = Ec2Instance.find params[:instance_id] 
    elsif params[:volume_id]
      @ec2_parent = Ec2Volume.find params[:volume_id]
    end
    @parent = @ec2_parent.class.to_s.underscore.gsub("ec2_", "")
  end
end
