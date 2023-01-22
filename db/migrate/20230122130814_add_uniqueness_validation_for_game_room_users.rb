class AddUniquenessValidationForGameRoomUsers < ActiveRecord::Migration[7.0]
  def change
    add_index :game_room_users, [:game_room_id, :user_id], unique: true
  end
end
