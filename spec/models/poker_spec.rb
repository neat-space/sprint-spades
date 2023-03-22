# == Schema Information
#
# Table name: pokers
#
#  id           :bigint           not null, primary key
#  remarks      :text
#  story_points :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  issue_id     :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_pokers_on_issue_id              (issue_id)
#  index_pokers_on_user_id               (user_id)
#  index_pokers_on_user_id_and_issue_id  (user_id,issue_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#  fk_rails_...  (user_id => users.id)
#

require 'rails_helper'

RSpec.describe Poker, type: :model do
  subject { create(:poker) }

  describe 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:issue) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:story_points) }
    it { is_expected.to validate_numericality_of(:story_points) }
    it { is_expected.to validate_inclusion_of(:story_points).in_array([0, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144]) }
    it { is_expected.to validate_uniqueness_of(:user_id).scoped_to(:issue_id).with_message('should be unique') }
    it { is_expected.to validate_length_of(:remarks).is_at_most(255) }
  end

  describe 'callbacks' do
    it { is_expected.to callback(:update_issue_average_story_points).after(:save) }
    it { is_expected.to callback(:broadcast_to_player_table).after(:commit) }
  end

  describe 'private methods' do
    describe '#update_issue_average_story_points' do
      it 'updates issue average story points' do
        subject.update_attribute(:story_points, 5)
        expect(subject.issue.average_story_points).to eq(5)
      end
    end
  end
end
