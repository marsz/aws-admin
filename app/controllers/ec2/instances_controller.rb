class Ec2::InstancesController < ApplicationController
  # GET /ec2/instances
  # GET /ec2/instances.json
  def index
    @ec2_instances = Ec2Instance.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @ec2_instances }
    end
  end

  # GET /ec2/instances/1
  # GET /ec2/instances/1.json
  def show
    @ec2_instance = Ec2Instance.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @ec2_instance }
    end
  end

  # GET /ec2/instances/new
  # GET /ec2/instances/new.json
  def new
    @ec2_instance = Ec2Instance.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @ec2_instance }
    end
  end

  # GET /ec2/instances/1/edit
  def edit
    @ec2_instance = Ec2Instance.find(params[:id])
  end

  # POST /ec2/instances
  # POST /ec2/instances.json
  def create
    @ec2_instance = Ec2Instance.new(params[:ec2_instance])

    respond_to do |format|
      if @ec2_instance.save
        format.html { redirect_to ec2_instance_snapshots_path(@ec2_instance), :notice => I18n.t('activerecord.successful.messages.created') }
        format.json { render :json => @ec2_instance, :status => :created, :location => ec2_instance_path(@ec2_instance) }
      else
        flash[:error] = @ec2_instance.errors.full_messages
        format.html { render :action => "new" }
        format.json { render json: @ec2_instance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /ec2/instances/1
  # PUT /ec2/instances/1.json
  def update
    @ec2_instance = Ec2Instance.find(params[:id])

    respond_to do |format|
      if @ec2_instance.update_attributes(params[:ec2_instance])
        format.html { redirect_to ec2_instance_snapshots_path(@ec2_instance), :notice => I18n.t('activerecord.successful.messages.updated') }
        format.json { head :no_content }
      else
        flash[:error] = @ec2_instance.errors.full_messages
        format.html { render :action => "edit" }
        format.json { render :json => @ec2_instance.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /ec2_instances/1
  # DELETE /ec2_instances/1.json
  def destroy
    @ec2_instance = Ec2Instance.find(params[:id])
    @ec2_instance.snapshots.each{ |snapshot| snapshot.destroy } if params[:dependency]
    @ec2_instance.destroy

    respond_to do |format|
      format.html { redirect_to ec2_instances_url, :notice => I18n.t('activerecord.successful.messages.destroied') }
      format.json { head :no_content }
    end
  end
end
