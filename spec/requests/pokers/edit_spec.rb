require 'rails_helper'

RSpec.describe "Pokers#edit", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room, creator: user) }
  let!(:issue) { create(:issue, game_room: game_room) }
  let!(:poker) { create(:poker, user: user, issue: issue) }

  before do
    sign_in user
    get edit_game_room_poker_path(game_room, poker)
  end

  it "assigns @poker" do
    expect(assigns(:poker)).to eq(poker)
  end

  it "assigns @issue" do
    expect(assigns(:issue)).to eq(issue)
  end

  it "is successful" do
    expect(response).to be_successful
  end
end