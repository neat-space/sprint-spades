require 'rails_helper'

RSpec.describe "Pokers#new", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room, creator: user) }
  let!(:issue) { create(:issue, game_room: game_room) }

  before do
    sign_in user
    get new_game_room_poker_path(game_room)
  end

  it "assigns @poker" do
    expect(assigns(:poker)).to be_a_new(Poker)
  end

  it "assigns @issue" do
    expect(assigns(:issue)).to eq(issue)
  end

  it "is successful" do
    expect(response).to be_successful
  end
end