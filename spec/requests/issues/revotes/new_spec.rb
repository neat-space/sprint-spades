require 'rails_helper'

RSpec.describe "Issues/Revotes#new", type: :request do
  let(:user) { create(:user) }
  let(:game_room) { create(:game_room) }
  let(:issue) { create(:issue, game_room: game_room, points_revealed_at: Time.now) }

  before do
    sign_in user
    user.add_role(:owner, game_room)
    get new_game_room_issue_revotes_path(game_room, issue)
  end

  it "assigns @issue" do
    expect(assigns(:issue)).to eq(issue)
  end

  it "renders successfully" do
    expect(response).to be_successful
  end
end