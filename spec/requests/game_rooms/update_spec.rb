# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "GameRooms#update", type: :request do
  let!(:game_room) { create(:game_room) }

  before do
    sign_in game_room.creator
  end

  context "when the game_room is valid" do
    it "updates the game_room" do
      patch game_room_path(game_room), params: { game_room: { name: "My Game Room" } }
      expect(game_room.reload.name).to eq("My Game Room")
    end

    it "redirects to the game_room" do
      patch game_room_path(game_room), params: { game_room: { name: "My Game Room" } }
      expect(response).to redirect_to(game_room_url(game_room))
    end
  end

  context "when the game_room is invalid" do
    it "does not update the game_room" do
      patch game_room_path(game_room), params: { game_room: { name: "" } }
      expect(game_room.reload.name).not_to eq("")
    end

    it "renders the edit template" do
      patch game_room_path(game_room), params: { game_room: { name: "" } }
      expect(response).to render_template(:edit)
    end
  end
end