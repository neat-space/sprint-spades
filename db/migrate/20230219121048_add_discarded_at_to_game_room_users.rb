class AddDiscardedAtToGameRoomUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :game_room_users, :discarded_at, :datetime
    add_index :game_room_users, :discarded_at
  end
end
