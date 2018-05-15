Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: { format: :json } do
    # 'Pusher' routes
    post   'pusher/auth',              to: 'pusher#auth'

    # 'Users' routes
    get    'users',                    to: 'users#find_user'
    post   'users',                    to: 'users#create_user'
    put    'users',                    to: 'users#edit_user'

    # 'Connections' routes
    get    'connections',              to: 'connections#get_connections'
    post   'connections',              to: 'connections#request_connection'
    delete 'connections/:user_id',     to: 'connections#block_connection'

    # 'Messages' routes
    get    'messages/direct/:user_id', to: 'messages#get_direct_messages'
    post   'messages/direct',          to: 'messages#create_direct_message'
  end
end
