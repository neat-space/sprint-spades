require 'rails_helper'

RSpec.describe "Pokers#show", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room, creator: user) }
  let!(:issue) { create(:issue, game_room: game_room) }
  let!(:poker) { create(:poker, user: user, issue: issue) }

  before do
    sign_in user
    get game_room_poker_path(game_room, poker)
  end

  it "assigns @poker" do
    expect(assigns(:poker)).to eq(poker)
  end

  it "assigns @game_room" do
    expect(assigns(:game_room)).to eq(game_room)
  end

  it "is successful" do
    expect(response).to be_successful
  end
end