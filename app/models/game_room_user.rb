class GameRoomUser < ApplicationRecord
  belongs_to :game_room
  belongs_to :user

  validates :user_id, uniqueness: { scope: :game_room_id, message: "should be unique" }

  after_commit :broadcast_create

  private

    def broadcast_create
      broadcast_replace_to game_room, target: "player_table", partial: 'game_rooms/components/player_table', locals: { game_room:, user:, issue: game_room.current_issue}
    end
end
