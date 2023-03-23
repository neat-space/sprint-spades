# == Schema Information
#
# Table name: pokers
#
#  id           :bigint           not null, primary key
#  remarks      :text
#  story_points :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  issue_id     :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_pokers_on_issue_id              (issue_id)
#  index_pokers_on_user_id               (user_id)
#  index_pokers_on_user_id_and_issue_id  (user_id,issue_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#  fk_rails_...  (user_id => users.id)
#
class Poker < ApplicationRecord
  belongs_to :user
  belongs_to :issue, counter_cache: true

  validates :story_points, presence: true, numericality: true, inclusion: { in: [0, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144] }
  validates :user_id, uniqueness: { scope: :issue_id, message: "should be unique" }
  validates :remarks, length: { maximum: 255 }

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
