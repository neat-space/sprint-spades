require 'rails_helper'

RSpec.describe "Issues/RevealVotes#update", type: :request do
  let(:user) { create(:user) }
  let(:game_room) { create(:game_room) }
  let(:issue) { create(:issue, game_room: game_room) }

  before do
    sign_in user
    user.add_role(:admin, game_room)
    put game_room_issue_reveal_votes_path(game_room, issue)
  end

  it "updates the issue's points_revealed_at" do
    expect(issue.reload.points_revealed_at).to be_present
  end

  it "redirects to the game_room_url" do
    expect(response).to redirect_to(game_room_url(game_room))
  end

  it "sets a flash notice" do
    expect(flash[:notice]).to eq("Points revealed!")
  end
end