class GameRoomPolicy < ApplicationPolicy
  def show?
    game_room_users_exists?
  end

  def create?
    true
  end

  def update?
    user_created_game_room?
  end

  def edit?
    update?
  end

  def destroy?
    user_created_game_room?
  end

  class Scope < Scope
    def resolve
      user.game_rooms.all
    end
  end

  private

  def game_room_users_exists?
    record.users.include?(user)
  end

  def user_created_game_room?
    record.user_id == user.id
  end
end
