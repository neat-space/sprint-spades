require 'rails_helper'

RSpec.describe GameRoomUserPolicy do
  subject { described_class.new(user, game_room_user) }

  let(:game_room_user) { create(:game_room_user) }

  context "when user is any user" do
    let(:user) { create(:user) }
    
    it { is_expected.to permit_action(:create) }
    it { is_expected.to forbid_actions([:destroy, :add_role, :remove_role]) }
  end

  context "when user is the owner" do
    let(:user) { game_room_user.user }

    context "when record is not kept" do
      before do
        game_room_user.discard
      end

      it { is_expected.to forbid_actions([:destroy, :add_role, :remove_role]) }
    end

    context "when record is kept" do
      context "when user is the creator" do
        it { is_expected.to permit_actions([:destroy]) }
        it { is_expected.to forbid_actions([:add_role, :remove_role]) }
      end

      context "when user is not the creator" do
        let(:user) { create(:user) }
        before do
          user.add_role(:owner, game_room_user.game_room)
        end

        it { is_expected.to permit_actions([:destroy, :add_role, :remove_role]) }
      end
    end
  end

  context "when user is a member" do
    let(:user) { create(:user) }
    before { game_room_user.game_room.users << user }

    it { is_expected.to forbid_actions([:destroy, :add_role, :remove_role]) }
  end

  context "when user is an admin" do
    let(:user) { create(:user) }
    before { game_room_user.game_room.users << user; user.add_role(:admin, game_room_user.game_room) }

    it { is_expected.to forbid_actions([:destroy, :add_role, :remove_role]) }
  end
end