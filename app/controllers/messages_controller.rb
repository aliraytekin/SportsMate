class MessagesController < ApplicationController
  def create
    @message = current_user.sent_messages.build(message_params)
    @user = User.find(@message.recipient_id)

    if @message.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to chat_user_path(@user) }
      end
    else
      render "users/chat", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :recipient_id)
  end
end
