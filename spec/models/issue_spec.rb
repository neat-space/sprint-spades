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
# 

require 'rails_helper'

RSpec.describe Issue, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:game_room) }
    it { is_expected.to have_many(:pokers).dependent(:destroy) }
  end

  describe 'callbacks' do
    it { is_expected.to callback(:update_game_room_current_issue).after(:commit) }
    it { is_expected.to callback(:set_next_issue_as_current_issue).after(:destroy) }
    it { is_expected.to callback(:broadcast_issue_destroy).after(:commit) }
    it { is_expected.to callback(:broadcast_entire_room).after(:commit) }
  end

  describe "private methods" do
    describe "#update_game_room_current_issue" do
      let(:issue) { create(:issue) }

      it "updates the game room's current issue" do
        expect(issue.game_room.current_issue_id).to eq(issue.id)
      end
    end

    describe "#set_next_issue_as_current_issue" do
      let!(:game_room) { create(:game_room) }
      let!(:issue) { create(:issue, game_room:) }
      let!(:second_issue) { create(:issue, game_room:) }

      it "sets the next issue as the current issue" do
        second_issue.destroy
        game_room.reload
        expect(game_room.current_issue_id).to eq(issue.id)
      end
    end
  end
end
