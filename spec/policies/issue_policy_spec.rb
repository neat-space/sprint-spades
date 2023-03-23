require 'rails_helper'

RSpec.describe IssuePolicy do
  subject { described_class.new(user, issue) }

  let(:issue) { create(:issue) }
  let(:user) { create(:user) }

  context "when user is any user" do
    it { is_expected.to forbid_actions([:update, :edit, :destroy, :reveal_votes, :set_current_issue, :revote]) }
  end

  context "when user is an owner of the game_room" do
    before { user.add_role(:owner, issue.game_room) }

    it { is_expected.to permit_actions([:update, :edit, :destroy, :reveal_votes, :set_current_issue]) }
    it { is_expected.to forbid_action(:revote) }
  end

  context "when user is an admin of the game room" do
    before { user.add_role(:admin, issue.game_room) }

    it { is_expected.to permit_actions([:update, :edit, :destroy, :reveal_votes, :set_current_issue]) }
    it { is_expected.to forbid_action(:revote) }

    context "when points_revealed_at is present in the issue" do
      before { issue.update(points_revealed_at: Time.now) }

      it { is_expected.to permit_action(:reveal_votes) }
    end
  end
end