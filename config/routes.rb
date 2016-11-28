Rails.application.routes.draw do
  mount ChinaCity::Engine => '/china_city'
  resources :orders
    get 'orders/submitorder/:id',  to:  'orders#submitorder'
  resources :cars   do
    collection  do
      get 'reduce'
      get 'add'
      get 'count'
      get 'count_num'
    end
  end

  resources :products
  get 'welcome/index'

  devise_for :users, controllers: { sessions: "users/sessions" }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root :to => "welcome#index"
  resources :types
     get 'deletecheck', to: 'types#deletecheck'
   resources  :books   do
     collection  do
      get  'batch_add'   
      get  'checkname'
     end
     end
    get  '/checktypeid/:type_id',  to:  'books#checktypeid'
   resources  :infos
   resources  :languages
end