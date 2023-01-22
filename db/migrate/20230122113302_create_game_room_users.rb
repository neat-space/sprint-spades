class CreateGameRoomUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :game_room_users do |t|
      t.references :game_room, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
