class IssuePolicy < ApplicationPolicy
  def create?
    record&.game_room&.creator == user
  end

  def update?
    record&.game_room&.creator == user
  end

  def destroy?
    record&.game_room&.creator == user
  end

  def reveal_votes?
    record&.game_room&.creator == user
  end

  def set_current_issue?
    record&.game_room&.creator == user
  end
end
