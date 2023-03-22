# == Schema Information
#
# Table name: game_room_users
#
#  id           :bigint           not null, primary key
#  discarded_at :datetime
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  game_room_id :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_game_room_users_on_discarded_at              (discarded_at)
#  index_game_room_users_on_game_room_id              (game_room_id)
#  index_game_room_users_on_game_room_id_and_user_id  (game_room_id,user_id) UNIQUE
#  index_game_room_users_on_user_id                   (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (game_room_id => game_rooms.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :game_room_user do
    game_room
    user
    discarded_at { nil }
  end
end
