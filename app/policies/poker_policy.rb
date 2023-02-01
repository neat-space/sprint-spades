class PokerPolicy < ApplicationPolicy
  def create?
    record&.issue&.game_room&.users&.include?(user)
  end

  def update?
    record&.issue&.game_room&.users&.include?(user)
  end

  def destroy?
    record&.issue&.game_room&.users&.include?(user)
  end
end
