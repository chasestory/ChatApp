class MessagesController < ApplicationController
	before_action :authenticate_user!
	before_action :set_chatroom


	def create
		message = @chatroom.messages.new(message_params)
		message.user = current_user
		message.save
		MessageRelayJob.perform_later(message)
	end

	def destroy
		message = Message.find(params[:id])

		if current_user.id == message.user_id || current_user.try(:admin?)
			respond_to do |format|
				if message.destroy
					format.html { redirect_to chatroom_path(params[:chatroom_id]), notice: "Successfully deleted message!" }
					format.json { head :no_content }
				# else
				# 	format.js { render @chatrooms }
				# 	format.json { render json: @chatroom.errors, status: :unprocessable_entity }
				end
			end
		end
	end
	

	private

	def set_chatroom
		@chatroom = Chatroom.find(params[:chatroom_id])
	end

	def message_params
		params.require(:message).permit(:body)
	end
end