# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:pokers).dependent(:destroy) }
    it { should have_many(:identities).dependent(:delete_all) }
    it { should have_many(:game_room_users).dependent(:destroy) }
    it { should have_many(:game_rooms).through(:game_room_users) }
    it { should have_many(:created_game_rooms).class_name('GameRoom').with_foreign_key('user_id') }
    it { should have_and_belong_to_many(:roles) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'methods' do
    let(:user) { create(:user) }
    let(:issue) { create(:issue) }
    let(:poker) { create(:poker, user: user, issue: issue) }

    describe '#name' do
      it 'returns the name of the user' do
        expect(user.name).to eq("#{user.first_name} #{user.last_name}")
      end
    end

    describe '#already_voted?' do
      it 'returns true if user has voted for the issue' do
        poker
        expect(user.already_voted?(issue)).to eq(true)
      end

      it 'returns false if user has not voted for the issue' do
        expect(user.already_voted?(issue)).to eq(false)
      end
    end

    describe '#points_for' do
      it 'returns the points for the issue' do
        poker
        expect(user.points_for(issue)).to eq(poker.story_points)
      end

      it 'returns nil if user has not voted for the issue' do
        expect(user.points_for(issue)).to eq(nil)
      end
    end
  end
end
