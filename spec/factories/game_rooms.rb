# == Schema Information
#
# Table name: game_rooms
#
#  id               :bigint           not null, primary key
#  name             :string
#  token            :string           not null
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  current_issue_id :integer
#  user_id          :bigint           not null
#
# Indexes
#
#  index_game_rooms_on_current_issue_id  (current_issue_id)
#  index_game_rooms_on_user_id           (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :game_room do
    name { Faker::Lorem.word }
    token { Faker::Lorem.word }
    association :creator, factory: :user
  end
end
