class Chatroom < ApplicationRecord
	has_many :chatroom_users, dependent: :destroy
	has_many :users, through: :chatroom_users
	has_many :messages, dependent: :destroy

	validates :name, presence: true, uniqueness: true

	scope :public_channels, -> { where(direct_message: false) }
	scope :direct_messages, -> { where(direct_message: true)}

	def self.direct_message_for_users(users)
		user_ids = users.map(&:username).sort
		name = "Direct Message:	#{user_ids.join(" : ")}"
		
		if chatroom = direct_messages.where(name: name).first
			chatroom
		else
			chatroom = new(name: name, direct_message: true)
			chatroom.users = users
			chatroom.save
			chatroom
		end
	end

end
