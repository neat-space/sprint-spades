class PokerPolicy < ApplicationPolicy
  def create?
    user_is_active?
  end

  def show?
    user_is_active?
  end

  def update?
    user_is_active?
  end

  def destroy?
    user_is_active?
  end

  private

    def user_is_active?
      record&.issue&.game_room&.game_room_users&.kept&.exists?(user_id: user.id)
    end
end
