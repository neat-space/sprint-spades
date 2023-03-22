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
require 'rails_helper'

RSpec.describe GameRoomUser, type: :model do
  subject { create(:game_room_user) }

  describe 'associations' do
    it { is_expected.to belong_to(:game_room) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:game_room_id).with_message('should be unique') }
  end

  describe 'delegations' do
    it { is_expected.to delegate_method(:name).to(:user) }
    it { is_expected.to delegate_method(:email).to(:user) }
  end

  describe 'callbacks' do
    it { is_expected.to callback(:broadcast_create).after(:commit) }
    it { is_expected.to callback(:remove_all_roles).after(:discard) }
    it { is_expected.to callback(:destroy_if_no_game_users_left).after(:discard) }
  end

  describe 'private methods' do
    describe '#remove_all_roles' do
      let(:game_room_user) { create(:game_room_user) }

      before do
        subject.discard
        subject.reload
      end

      it "removes all roles from user when discarding game room user" do
        expect(game_room_user.user.roles.where(resource: game_room_user.game_room)).to be_empty        
      end

      it 'adds owner role to the first user in the game room' do
        expect(game_room_user.game_room.roles.pluck(:name)).to include('owner')
      end
    end

    describe '#destroy_if_no_game_users_left' do
      let(:game_room) { create(:game_room) }

      before do
        game_room.game_room_users.kept.first.discard
      end

      it 'destroys the game room if there are no game room users left' do
        expect(game_room).to be_destroyed
      end
    end
  end
end
