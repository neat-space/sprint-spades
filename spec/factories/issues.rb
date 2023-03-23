# == Schema Information
#
# Table name: issues
#
#  id                   :bigint           not null, primary key
#  average_story_points :float            default(0.0), not null
#  points_revealed_at   :datetime
#  pokers_count         :integer          default(0), not null
#  title                :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  game_room_id         :bigint           not null
#
# Indexes
#
#  index_issues_on_game_room_id  (game_room_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_room_id => game_rooms.id)
#

FactoryBot.define do
  factory :issue do
    title { Faker::Lorem.word }
    game_room
  end
end
