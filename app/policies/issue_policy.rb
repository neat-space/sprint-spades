class IssuePolicy < ApplicationPolicy
  def new?
    user_is_an_admin_or_owner?(record.game_room)
  end

  def create?
    new?
  end

  def update?
    user_is_an_admin_or_owner?(record.game_room)
  end

  def edit?
    update?
  end

  def destroy?
    user_is_an_admin_or_owner?(record.game_room)
  end

  def reveal_votes?
    user_is_an_admin_or_owner?(record.game_room)
  end

  def set_current_issue?
    user_is_an_admin_or_owner?(record.game_room)
  end

  def revote?
    user.has_role?(:owner, record.game_room) && record.points_revealed_at.present?
  end

  private

    def user_is_an_admin_or_owner?(record)
      user.has_role?(:owner, record) || user.has_role?(:admin, record)
    end
end
