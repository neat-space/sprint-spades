class Poker < ApplicationRecord
  belongs_to :user
  belongs_to :issue

  validates :story_points, presence: true, numericality: true
  validates :user_id, uniqueness: true, scope: :issue_id, message: "should be unique"
end
