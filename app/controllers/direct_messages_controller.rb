class DirectMessagesController < ApplicationController
	before_action :authenticate_user!

	def show
		users = [current_user, User.find(params[:id])]
		@chatroom = Chatroom.direct_message_for_users(users)
		@messages = @chatroom.messages.order(created_at: :desc).limit(100).reverse
		@chatroom_user = current_user.chatroom_users.find_by(chatroom_id: @chatroom.id)
		render "chatrooms/show"
	end


	def destroy
		message = Message.find(params[:id])
    if message.destroy
			respond_to do |format|
				format.html { render status: 200, notice: 'message was successfully destroyed.' }
				format.json { head :no_content }
			end
		else
			flash.notice "error deleting"
		end
	end

end