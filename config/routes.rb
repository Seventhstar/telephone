Telephone::Application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  get 'task_history/index'

  get 'client/index'

  resources :tasks

  resources :reports
  resources :updates
  resources :servers
  resources :backups
  resources :duties_suggestions
  resources :bases

  devise_for :user
  devise_scope :user do
    get "signup", :to => "devise/registrations#new"
    get "login", :to => "devise/sessions#new"
    get "logout", :to => "devise/sessions#destroy"
  end

  root :to => "phones#index"

  resources :phone_mags
  resources :group_mags
  resources :mobiles
  resources :otdels
  resources :positions
  resources :priorities
  resources :states
  resources :task_types
  resources :components
  resources :task_depts
  resources :task_history
  resources :clients
  get "ajax/clients"

  resources :phones do
    collection { post :import }
    get :autocomplete_otdel_name, :on => :collection
    get :autocomplete_position_name, :on => :collection
  end

  get "ajax/otdels"
  get "ajax/positions"

  get "csv/import"
  get "csv/export"
  get "csv/import_mag"

  post "csv/import" => 'csv#upload'
  post "csv/import_mag" => 'csv#upload_mag'

  get "pages/upload"
  post "pages/upload" => 'pages#upload'

  get    'options'  => 'options#edit'
  get    'options/:options_page'  => 'options#edit',:constraints => {:format => /(json|html)/}
  post   'options/:options_page' => 'options#create'
  delete 'options/:options_page/:id' => 'options#destroy'
  post "ajax/upd_param"

end
