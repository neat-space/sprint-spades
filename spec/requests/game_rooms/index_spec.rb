# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "GameRooms#index", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room) }
  let!(:game_room_user) { create(:game_room_user, game_room:, user:) }

  before do
    sign_in user
  end

  it "assigns @game_rooms" do
    get game_rooms_path
    expect(assigns(:game_rooms)).to eq([game_room])
  end

  it "renders the index template" do
    get game_rooms_path
    expect(response).to be_successful
  end
end