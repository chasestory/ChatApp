class DirectMesssagesController < ApplicationController
before_action :authenticate_user!

	def show
		users = [current_user, User.find(params[:id])]
	@chatroom = Chatroom.direct_messages_for_users([current_user, User.find(params[:id])])
	end


end