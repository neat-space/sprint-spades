# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "GameRooms#show", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room) }
  let!(:game_room_user) { create(:game_room_user, game_room:, user:) }

  before do
    sign_in user
  end

  it "assigns @game_room" do
    get game_room_path(game_room)
    expect(assigns(:game_room)).to eq(game_room)
  end

  it "renders the show template" do
    get game_room_path(game_room)
    expect(response).to be_successful
  end
end