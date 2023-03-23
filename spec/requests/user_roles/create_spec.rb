require 'rails_helper'

RSpec.describe "UserRoles#create", type: :request do
  let(:user) { create(:user) }
  let(:game_room) { create(:game_room) }
  let(:game_room_user) { create(:game_room_user, game_room: game_room, user: user) }

  before do
    sign_in game_room.creator
  end

  context "when game_room_user is successfully added as an admin" do
    before do
      post game_room_user_roles_path(game_room, game_room_user_id: game_room_user.id)
    end

    it "adds the user as an admin" do
      expect(user.has_role?(:admin, game_room)).to be true
    end

    it "redirects to the game_room_url" do
      expect(response).to redirect_to(game_room_url(game_room))
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq("Succesfully added #{user.name} as an admin.")
    end
  end

  context "when game_room_user is not successfully added as an admin" do
    before do
      allow_any_instance_of(User).to receive(:add_role).and_return(false)
      post game_room_user_roles_path(game_room, game_room_user_id: game_room_user.id)
    end

    it "redirects to the game_room_url" do
      expect(response).to redirect_to(game_room_url(game_room))
    end

    it "sets a flash alert" do
      expect(flash[:alert]).to eq("Something went wrong.")
    end
  end
end