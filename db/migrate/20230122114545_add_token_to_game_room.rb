class AddTokenToGameRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :game_rooms, :token, :string, null: false
  end
end
