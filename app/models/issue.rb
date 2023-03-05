class Issue < ApplicationRecord
  include ActionView::RecordIdentifier

  attr_accessor :delete_previous_votes

  belongs_to :game_room
  has_many :pokers, dependent: :destroy

  validates :title, presence: true

  after_create_commit :update_game_room_current_issue
  after_destroy :set_next_issue_as_current_issue
  after_destroy_commit :broadcast_issue_destroy
  after_update_commit :broadcast_entire_room

  private

  def update_game_room_current_issue
    game_room.update(current_issue_id: id)
  end


  def broadcast_issue_destroy
    game_room.users.each do |user|
      Current.user = user
      broadcast_remove_to game_room, Current.user, target: dom_id(self)
    end
  end

  def set_next_issue_as_current_issue
    return unless game_room.current_issue_id == id

    game_room.update(current_issue_id: nil)
  end

  def broadcast_entire_room
    game_room.users.each do |user|
      Current.user = user

      broadcast_update_to game_room, Current.user, target: "game_room", partial: "game_rooms/game_room", locals: { game_room: self.game_room }
    end
  end
end
