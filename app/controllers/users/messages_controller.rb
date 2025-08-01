module Users
  class MessagesController < ApplicationController
    respond_to :json

    def index
      messages = Message.get_user_messages(current_user._id)
      render json: messages.to_json, status: :ok
    end

    def create
      Message.new(message_params.merge(user_id: current_user.id)).save!
      head :ok
    rescue
      head :unprocessable_entity
    end

    private

    def message_params
      params.require(:user).permit(:phone_number, :message)
    end
  end
end
