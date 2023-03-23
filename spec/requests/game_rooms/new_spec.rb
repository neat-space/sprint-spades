# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "GameRooms#new", type: :request do
  let!(:user) { create(:user) }
  
  before do
    sign_in user
  end

  it "initializes a new game_room" do
    get new_game_room_path
    expect(assigns(:game_room)).to be_a_new(GameRoom)
  end

  it "is successful" do
    get new_game_room_path
    expect(response).to be_successful
  end
end