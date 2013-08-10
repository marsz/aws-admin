class UsersController < ApplicationController
  load_and_authorize_resource :user
  
  def index
    @users = User.scoped
  end

  def new
    @user = User.new
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    authorize! :change_is_admin, @user if params[:user][:is_admin]
    if update_password(@user) && @user.update_attributes(params[:user])
      redirect_to users_path, :notice => I18n.t('activerecord.successful.messages.updated')
    else
      flash[:error] = @user.errors.full_messages.first
      render :edit
    end
  end
  
  def create
    @user = User.new params[:user]
    if @user.save
      redirect_to users_path, :notice => I18n.t('activerecord.successful.messages.created')
    else
      flash[:error] = @user.errors.full_messages.first
      render :new
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    redirect_to users_path, :notice => I18n.t('activerecord.successful.messages.destroied')
  end
  
  private 
  
  def update_password user
    if params[:user][:password].present? && can?(:with_current_password, User)
      res = user.update_with_password params[:user]
      return res
    end
    if can?(:with_current_password, User) || params[:user][:password].blank?
      params[:user].delete(:current_password) 
      params[:user].delete(:password) 
      params[:user].delete(:password_confirmation)
    end
    true
  end
  
end
