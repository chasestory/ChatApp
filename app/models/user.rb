class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :username, uniqueness: true

  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable
  has_many :chatroom_users
  has_many :chatrooms, through: :chatroom_users
  has_many :messages

  # scope :online, ->{ where("last_seen_at > ?", 1.minutes.ago) }

  def self.online
    ids = ActionCable.server.pubsub.redis_connection_for_subscriptions.smembers "online"
    where(id: ids)
  end


  # def self.offline
  #   ids = ActionCable.server.pubsub.redis_connection_for_subscriptions.smembers "offline"
  #   where(id: ids)
  # end
end
