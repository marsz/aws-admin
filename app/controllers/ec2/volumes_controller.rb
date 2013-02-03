class Ec2::VolumesController < ApplicationController
  # GET /ec2/volumes
  # GET /ec2/volumes.json
  def index
    @ec2_volumes = Ec2Volume.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @ec2_volumes }
    end
  end

  # GET /ec2/volumes/1
  # GET /ec2/volumes/1.json
  def show
    @ec2_volume = Ec2Volume.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @ec2_volume }
    end
  end

  # GET /ec2/volumes/new
  # GET /ec2/volumes/new.json
  def new
    @ec2_volume = Ec2Volume.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @ec2_volume }
    end
  end

  # GET /ec2/volumes/1/edit
  def edit
    @ec2_volume = Ec2Volume.find(params[:id])
  end

  # POST /ec2/volumes
  # POST /ec2/volumes.json
  def create
    @ec2_volume = Ec2Volume.new(params[:ec2_volume])

    respond_to do |format|
      if @ec2_volume.save
        format.html { redirect_to ec2_volume_snapshots_path(@ec2_volume), :notice => I18n.t('activerecord.successful.messages.created') }
        format.json { render :json => @ec2_volume, :status => :created, :location => ec2_volume_path(@ec2_volume) }
      else
        flash[:error] = @ec2_volume.errors.full_messages
        format.html { render :action => "new" }
        format.json { render json: @ec2_volume.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ec2/volumes/1
  # PUT /ec2/volumes/1.json
  def update
    @ec2_volume = Ec2Volume.find(params[:id])

    respond_to do |format|
      if @ec2_volume.update_attributes(params[:ec2_volume])
        format.html { redirect_to ec2_volume_snapshots_path(@ec2_volume), :notice => I18n.t('activerecord.successful.messages.updated') }
        format.json { head :no_content }
      else
        flash[:error] = @ec2_volume.errors.full_messages
        format.html { render :action => "edit" }
        format.json { render :json => @ec2_volume.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ec2_volumes/1
  # DELETE /ec2_volumes/1.json
  def destroy
    @ec2_volume = Ec2Volume.find(params[:id])
    @ec2_volume.snapshots.each{ |snapshot| snapshot.destroy } if params[:dependency]
    @ec2_volume.destroy

    respond_to do |format|
      format.html { redirect_to ec2_volumes_url, :notice => I18n.t('activerecord.successful.messages.destroied') }
      format.json { head :no_content }
    end
  end
end
