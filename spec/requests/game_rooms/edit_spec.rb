# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "GameRooms#edit", type: :request do
  let!(:game_room) { create(:game_room) }

  before do
    sign_in game_room.creator
  end

  it "assigns @game_room" do
    get edit_game_room_path(game_room)
    expect(assigns(:game_room)).to eq(game_room)
  end

  it "renders the edit template" do
    get edit_game_room_path(game_room)
    expect(response).to be_successful
  end
end