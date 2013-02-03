AwsBackup::Application.routes.draw do
  devise_for :users

  root :to => 'application#index'
  namespace :ec2 do
    root :to => 'instances#index'
    resources :instances do
      resources :snapshots, :only => [:index, :destroy, :create]
    end
    resources :volumes do
      resources :snapshots, :only => [:index, :destroy, :create]
    end
  end
  resources :users
end
