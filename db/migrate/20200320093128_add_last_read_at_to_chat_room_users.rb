class AddLastReadAtToChatRoomUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :chat_room_users, :last_read_at, :datetime
  end
end
