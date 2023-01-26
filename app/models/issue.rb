class Issue < ApplicationRecord
  belongs_to :game_room
  has_many :pokers, dependent: :destroy

  after_create_commit :update_game_room_current_issue

  private

  def update_game_room_current_issue
    game_room.update(current_issue_id: id)
  end
end
