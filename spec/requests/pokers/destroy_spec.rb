require 'rails_helper'

RSpec.describe "Pokers#destroy", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room, creator: user) }
  let!(:issue) { create(:issue, game_room: game_room) }
  let!(:poker) { create(:poker, user: user, issue: issue) }

  before do
    sign_in user
    delete game_room_poker_path(game_room, poker)
  end

  it "destroys the poker" do
    expect(Poker.find_by(id: poker.id)).to be_nil
  end

  it "redirects to the game_room" do
    expect(response).to redirect_to(game_room_path(game_room))
  end
end