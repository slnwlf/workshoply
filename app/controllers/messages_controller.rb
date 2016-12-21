class MessagesController < ApplicationController

  def create
    @message = Message.new(message_params)
    if @message.valid?
      MessageMailer.message_me(@message).deliver_now
      redirect_to contact_path, notice: "Thank you for your message."
    else
      flash[:error] = @message.errors.full_messages.join(", ")
      redirect_to contact_path
    end
  end


  private

  def message_params
  	params.require(:message).permit(:form, :name, :email, :subject, :content, :company,  :location, :number_participants, :budget, :audience, :date)
  end

end
