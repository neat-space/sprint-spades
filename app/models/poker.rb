class Poker < ApplicationRecord
  belongs_to :user
  belongs_to :issue

  validates :story_points, presence: true, numericality: true
end
