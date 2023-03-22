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

require 'rails_helper'

RSpec.describe GameRoom, type: :model do
  describe 'associations' do
    it { should belong_to(:creator).class_name('User').with_foreign_key('user_id') }
    it { should belong_to(:current_issue).class_name('Issue').optional }
    it { should have_many(:issues).dependent(:destroy) }
    it { should have_many(:pokers).through(:issues).dependent(:destroy) }
    it { should have_many(:game_room_users).dependent(:destroy) }
    it { should have_many(:users).through(:game_room_users) }
  end

  describe 'callbacks' do
    it { should callback(:create_game_room_user).after(:commit) }
    it { should callback(:set_token).before(:create) }
    it { should callback(:set_owner_role).after(:create) }
    it { should callback(:broadcast_current_issue).after(:commit).if(:saved_change_to_current_issue_id?) }
  end

  describe 'methods' do
    let(:game_room) { create(:game_room) }

    describe '#create_game_room_user' do
      it 'creates game room user' do
        expect { game_room }.to change { GameRoomUser.count }.by(1)
      end
    end

    describe '#set_token' do
      it 'sets token' do
        expect(game_room.token).to be_present
      end
    end

    describe '#set_owner_role' do
      it 'sets owner role' do
        expect(game_room.creator.has_role?(:owner, game_room)).to be_truthy
      end
    end
  end
end
