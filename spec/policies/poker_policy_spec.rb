require 'rails_helper'

RSpec.describe PokerPolicy do
  subject { described_class.new(user, poker) }
  
  let(:user) { create(:user) }
  let(:poker) { create(:poker) }

  context "when user is any user" do
    it { is_expected.to forbid_actions([:create, :show, :update, :destroy]) }
  end

  context "when user is active" do
    before { poker.issue.game_room.game_room_users << create(:game_room_user, user: user) }

    it { is_expected.to permit_actions([:create, :show, :update, :destroy]) }
  end
end