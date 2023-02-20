class GameRoomUser < ApplicationRecord
  include Discard::Model

  belongs_to :game_room
  belongs_to :user

  delegate :name, :email, to: :user

  validates :user_id, uniqueness: { scope: :game_room_id, message: "should be unique" }

  after_commit :broadcast_create
  after_discard :remove_all_roles, :destroy_if_no_game_users_left

  private

    def broadcast_create
      game_room.users.each do |user|
        Current.user = user
        broadcast_replace_to game_room, Current.user, target: "player_table", partial: 'game_rooms/components/player_table', locals: { game_room:, user:, issue: game_room.current_issue}
      end
    end

    def remove_all_roles
      user.roles.where(resource: game_room).destroy_all
      add_owner_role if game_room.roles.pluck(:name).exclude?("owner")
    end

    def add_owner_role
      game_room.game_room_users.kept.first&.user&.add_role(:owner, game_room)
    end
    
    def destroy_if_no_game_users_left
      game_room.destroy if game_room.game_room_users.kept.empty?
    end

end
