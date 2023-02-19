class Poker < ApplicationRecord
  belongs_to :user
  belongs_to :issue, counter_cache: true

  validates :story_points, presence: true, numericality: true, inclusion: { in: [0, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144] }
  validates :user_id, uniqueness: { scope: :issue_id, message: "should be unique" }

  after_save :update_issue_average_story_points
  after_commit :broadcast_to_player_table

  private

    def update_issue_average_story_points
      issue.update_attribute(:average_story_points, issue.pokers.average(:story_points))
    end

    def broadcast_to_player_table
      issue.game_room.users.each do |user|
        Current.user = user
        broadcast_replace_to issue.game_room, Current.user, target: "player_table", partial: "game_rooms/components/player_table", locals: { game_room: issue.game_room, issue: issue }
      end
    end
end
