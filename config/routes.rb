Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    # 'Pusher' routes
    post   'pusher/auth',              to: 'pusher#auth'

    # 'Users' routes
    get    'users',                    to: 'users#find_user'
    post   'users',                    to: 'users#create_user'
    put    'users',                    to: 'users#edit_user'


    # 'Users' routes
    get    'connections',              to: 'connections#get_connections'
    post   'connections',              to: 'connections#request_connection'
    # del    'connections',              to: 'connections#delete_connection'

    # 'Messages' routes
    get    'messages/direct/:user_id', to: 'messages#get_direct_messages'
    get    'messages/group/:group_id', to: 'messages#get_group_messages'
    post   'messages/direct',          to: 'messages#create_direct_message'
    post   'messages/group',           to: 'messages#create_group_message'
  end
end
