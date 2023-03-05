class PokerPolicy < ApplicationPolicy
  def create?
    record&.issue&.game_room&.game_room_users&.kept&.exists?(user_id: user.id)
  end

  def show?
    record&.issue&.game_room&.game_room_users&.kept&.exists?(user_id: user.id)
  end

  def update?
    record&.issue&.game_room&.game_room_users&.kept&.exists?(user_id: user.id)
  end

  def destroy?
    record&.issue&.game_room&.game_room_users&.kept&.exists?(user_id: user.id)
  end
end
