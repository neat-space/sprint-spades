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
      user.game_room_users.kept.map(&:game_room)
    end
  end

  private

  def game_room_users_exists?
    record.game_room_users.kept.exists?(user_id: user.id)
  end

  def user_created_game_room?
    record.user_id == user.id
  end
end
