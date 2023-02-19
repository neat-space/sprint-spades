class GameRoomUserPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    record.kept? && (user.has_role?(:owner, record.game_room) || user.id == record.user_id)
  end

  def add_role?
    record.kept? && user.has_role?(:owner, record.game_room) && user.id != record.user_id
  end

  def remove_role?
    record.kept? && user.has_role?(:owner, record.game_room) && user.id != record.user_id
  end
end
