class Api::ConnectionsController < ApplicationController
  def get_connections
    @client, error = decode_token_and_find_user(request.headers['Authorization'])

    if error
      render json: [error], status: 401 and return
    end

    @users = Connection.query_connections(@client)

    render 'api/users/index'
  end

  def request_connection
    @client, error = decode_token_and_find_user(request.headers['Authorization'])

    if error
      render json: [error], status: 401 and return
    end

    # Determine which party is opposite to client's
    if @client[:political_party] == 'DEMOCRAT'
      opposite_party = 'REPUBLICAN'
    else
      opposite_party = 'DEMOCRAT'
    end

    # Find the user from opposite political_party who joined the queue first
    user = User.where('political_party = ? and queued_at IS NOT NULL and id NOT IN (?) and id NOT IN (?)', opposite_party, client.reds_as_blue.ids, client.blues_as_red.ids).order(:queued_at).last

    # If the queue is not empty...
    if user
      if @client[:political_party] == 'DEMOCRAT'
        blue_id = @client.id
        red_id  = user.id
      else
        red_id  = @client.id
        blue_id = user.id
      end

      # Create a connection with the user
      connection = Connection.new(({ blue_id: blue_id, red_id: red_id }))

      # And remove the user from the queue
      if connection.save && user.update({ queued_at: nil })
        Pusher.trigger('private-' + params[:user_id].to_s, 'receive-connection', { client:  @client })

        render 'api/users/show' and return
      else
        render json: connection.errors.full_messages, status: 422 and return
      end
    else
      # Add client to the queue
      if @client.update({ queued_at: Time.now })
        render 'api/users/show' and return
      else
        render json: @client.errors.full_messages, status: 422 and return
      end
    end
  end
end
