Rails.application.routes.draw do

  get 'photos/edit'

  get 'photos/new'

  root "sessions#new"

  get "/logout" => "sessions#logout"

  get "/auth/:provider/callback" => 'sessions#create'
  resources :sessions, only: [:new]
  resources :users, only: [:show,:destroy,:update]
  resources :events, except: [:new] do
    resources :comments, only: [:create, :edit, :update, :destroy], shallow: true
    resources :photos, only: [:edit, :create, :destroy, :update], shallow: true
  end

  get "send_to_google", to: "events#send_to_google", as: "send_to_google"

#         Prefix Verb   URI Pattern                          Controller#Action
#    photos_edit GET    /photos/edit(.:format)               photos#edit
#     photos_new GET    /photos/new(.:format)                photos#new
#           root GET    /                                    sessions#welcome
#       sessions POST   /sessions(.:format)                  sessions#create
#    new_session GET    /sessions/new(.:format)              sessions#new
#           user GET    /users/:id(.:format)                 users#show
#                DELETE /users/:id(.:format)                 users#destroy
# event_comments POST   /events/:event_id/comments(.:format) comments#create
#   edit_comment GET    /comments/:id/edit(.:format)         comments#edit
#        comment PATCH  /comments/:id(.:format)              comments#update
#                PUT    /comments/:id(.:format)              comments#update
#                DELETE /comments/:id(.:format)              comments#destroy
#   event_photos POST   /events/:event_id/photos(.:format)   photos#create
#     edit_photo GET    /photos/:id/edit(.:format)           photos#edit
#          photo PATCH  /photos/:id(.:format)                photos#update
#                PUT    /photos/:id(.:format)                photos#update
#                DELETE /photos/:id(.:format)                photos#destroy
#         events GET    /events(.:format)                    events#index
#                POST   /events(.:format)                    events#create
#     edit_event GET    /events/:id/edit(.:format)           events#edit
#          event GET    /events/:id(.:format)                events#show
#                PATCH  /events/:id(.:format)                events#update
#                PUT    /events/:id(.:format)                events#update
#                DELETE /events/:id(.:format)                events#destroy
end
