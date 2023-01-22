class Issue < ApplicationRecord
  belongs_to :game_room
  has_many :pokers, dependent: :destroy
end
