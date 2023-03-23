require 'rails_helper'

RSpec.describe GameRoomPolicy do
  subject { described_class.new(user, game_room) }

  let(:game_room) { create(:game_room) }

  context "when user is any user" do
    let(:user) { create(:user) }
    
    it { is_expected.to permit_action(:create) }
    it { is_expected.to forbid_actions([:show, :update, :edit, :destroy]) }
  end

  context "when user is the creator" do
    let(:user) { game_room.creator }

    it { is_expected.to permit_actions([:show, :create, :update, :edit, :destroy]) }
  end

  context "when user is a member" do
    let(:user) { create(:user) }
    before { game_room.users << user }

    it { is_expected.to permit_actions([:show, :create]) }
    it { is_expected.to forbid_actions([:update, :edit, :destroy]) }
  end

  context "when user is an admin" do
    let(:user) { create(:user) }
    before { game_room.users << user; user.add_role(:admin, game_room) }

    it { is_expected.to permit_actions([:show, :create, :update, :edit]) }
    it { is_expected.to forbid_action(:destroy) }
  end

  describe "scope" do
    subject { described_class::Scope.new(user, GameRoom.all).resolve }

    let(:user) { create(:user) }
    let!(:game_room) { create(:game_room) }
    let!(:game_room_user) { create(:game_room_user, user: user, game_room: game_room) }

    it { is_expected.to include(game_room) }
  end
end