# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "GameRooms#destroy", type: :request do
  let!(:game_room) { create(:game_room) }

  before do
    sign_in game_room.creator
  end

  it "destroys the game_room" do
    expect do
      delete game_room_path(game_room)
    end.to change(GameRoom, :count).by(-1)
  end

  it "redirects to the game_rooms" do
    delete game_room_path(game_room)
    expect(response).to redirect_to(game_rooms_url)
  end
end