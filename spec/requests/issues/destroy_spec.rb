require 'rails_helper'

RSpec.describe "Issues#destroy", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room) }
  let!(:issue) { create(:issue, game_room: game_room) }

  before do
    sign_in user
    user.add_role :admin, game_room
  end

  it "destroys the issue" do
    expect {
      delete game_room_issue_path(game_room, issue)
    }.to change(Issue, :count).by(-1)
  end

  it "redirects to the game_room" do
    delete game_room_issue_path(game_room, issue)
    expect(response).to redirect_to(game_room_path(game_room))
  end
end