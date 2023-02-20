class GameRoomPolicy < ApplicationPolicy
  def show?
    game_room_users_exists?
  end

  def create?
    true
  end

  def update?
    user.has_role?(:owner, record) || user.has_role?(:admin, record)
  end

  def edit?
    update?
  end

  def destroy?
    user.has_role?(:owner, record)
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
end
