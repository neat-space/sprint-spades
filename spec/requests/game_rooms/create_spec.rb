# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "GameRooms#create", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room) }

  before do
    sign_in user
  end

  context "when the game_room is valid" do
    it "creates a new game_room" do
      expect do
        post game_rooms_path, params: { game_room: { name: "My Game Room" } }
      end.to change(GameRoom, :count).by(1)
    end

    it "redirects to the game_room" do
      post game_rooms_path, params: { game_room: { name: "My Game Room" } }
      expect(response).to redirect_to(game_room_url(GameRoom.last))
    end
  end

  context "when the game_room is invalid" do
    it "does not create a new game_room" do
      expect do
        post game_rooms_path, params: { game_room: { name: "" } }
      end.not_to change(GameRoom, :count)
    end

    it "renders the new template" do
      post game_rooms_path, params: { game_room: { name: "" } }
      expect(response).to render_template(:new)
    end
  end
end