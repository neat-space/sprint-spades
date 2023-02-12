class Issue < ApplicationRecord
  include ActionView::RecordIdentifier

  belongs_to :game_room
  has_many :pokers, dependent: :destroy

  validates :title, presence: true

  after_create_commit :update_game_room_current_issue
  after_update_commit :broadcast_issue_update
  after_destroy :set_next_issue_as_current_issue
  after_destroy_commit :broadcast_issue_destroy
  after_update_commit :broadcast_entire_room

  private

  def update_game_room_current_issue
    game_room.update(current_issue_id: id)
  end

  def broadcast_issue_update
    game_room.users.each do |user|
      next if user == Current.user

      Current.user = user
      broadcast_update_to game_room, partial: "issues/issue", locals: { game_room: game_room, issue: self }
    end
  end

  def broadcast_issue_destroy
    broadcast_remove_to game_room, target: dom_id(self)
  end

  def set_next_issue_as_current_issue
    return unless game_room.current_issue_id == id

    game_room.update(current_issue_id: nil)
  end

  def broadcast_entire_room
    return unless points_revealed_at

    broadcast_update_to game_room, target: "vote_actions", partial: "pokers/components/revealed_points", locals: { issue: self }
    broadcast_update_to game_room, target: "player_table", partial: "game_rooms/components/player_table", locals: { game_room: game_room }
  end
end
