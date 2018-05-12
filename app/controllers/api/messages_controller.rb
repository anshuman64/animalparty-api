class Api::MessagesController < ApplicationController
  def get_direct_messages
    @client, error = decode_token_and_find_user(request.headers['Authorization'])

    if error
      render json: [error], status: 401 and return
    end

    if params[:is_new]
      @messages = Message.query_new_direct_messages(params[:start_at], @client.id, params[:user_id])
    else
      @messages = Message.query_direct_messages(params[:limit], params[:start_at], @client.id, params[:user_id])
    end

    render 'api/messages/index'
  end

  def create_direct_message
    @client, error = decode_token_and_find_user(request.headers['Authorization'])

    if error
      render json: [error], status: 401 and return
    end

    connection = Connection.find_connection(@client.id, params[:user_id])

    unless connection
      render json: ['Connection not found'], status: 404 and return
    end

    @message = Message.new({ author_id: @client.id, body: params[:body], connection_id: connection.id })

    if @message.save
      # Create medium for attached image or video
      if params[:medium]
        medium = Medium.new({ aws_path: params[:medium][:awsPath], mime_type: params[:medium][:mime], height: params[:medium][:height], width: params[:medium][:width], owner_id: @client.id, message_id: @message.id })

        unless medium.save
          render json: medium.errors.full_messages, status: 422 and return
        end
      end

      # pusher_message = get_pusher_message(@message, @client.id)
      # Pusher.trigger('private-' + params[:user_id].to_s, 'receive-message', { client_id:  @client.id, message: pusher_message })

      # create_notification(@client.id, params[:user_id], { en: @client[:username] }, get_message_notification_preview(@message), { type: 'receive-message', client_id: @client.id })

      render 'api/messages/show'
    else
      render json: @message.errors.full_messages, status: 422
    end
  end

end
