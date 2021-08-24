Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # root 'top#index'
  get '/', to: 'top#index', as: "top"
  get '/test', to: 'top#test'
  
  # ログアウト処理でなぜかgetされてしまうため追記
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end


  # storage controller
  get '/storage', to: 'storage#index', as: "storage_list"
  post '/storage', to: 'storage#create', as: "storage_create"
  
end
