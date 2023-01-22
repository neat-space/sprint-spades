class Poker < ApplicationRecord
  belongs_to :user
  validates :story_points, presence: true, numericality: true
end
