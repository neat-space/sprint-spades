class GameRoomUserPolicy < ApplicationPolicy
  def create?
    true
  end

  def destroy?
    record.kept? && (user == record.game_room.creator || user.id == record.user_id)
  end
end
