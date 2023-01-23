class Poker < ApplicationRecord
  belongs_to :user
  belongs_to :issue

  validates :story_points, presence: true, numericality: true, inclusion: { in: [0, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144] }
  validates :user_id, uniqueness: { scope: :issue_id, message: "should be unique" }
end
