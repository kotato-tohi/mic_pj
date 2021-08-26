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
  post '/storage', to: 'storage#create_storage', as: "storage_create"
  delete '/storage', to: 'storage#delete_storage', as: "storage_delete"

  get '/storage/items', to: 'storage#show_inside_storage', as: "storage_show_inside"  
  post '/storage/item', to: 'item#create_item_in_storage', as: "item_create"
  patch '/storage/item/update', to: 'item#change_item_status', as: "item_status_update"

end
