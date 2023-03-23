require 'rails_helper'

RSpec.describe "Issues/RevealVotes#new", type: :request do
  let(:user) { create(:user) }
  let(:game_room) { create(:game_room) }
  let(:issue) { create(:issue, game_room: game_room) }

  before do
    sign_in user
    user.add_role(:admin, game_room)
    get new_game_room_issue_reveal_votes_path(game_room, issue)
  end

  it "assigns @issue" do
    expect(assigns(:issue)).to eq(issue)
  end

  it "renders successfully" do
    expect(response).to be_successful
  end
end