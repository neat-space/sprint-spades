# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Issues#update", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room) }
  let!(:issue) { create(:issue, game_room: game_room) }

  before do
    sign_in user
    user.add_role :admin, game_room
    patch game_room_issue_path(game_room, issue), params: { issue: { title: "New Issue" } }
  end

  it "updates an issue" do
    expect(issue.reload.title).to eq("New Issue")
  end

  it "redirects to the game_room_url" do
    expect(response).to redirect_to(game_room_url(game_room))
  end

  it "sets a flash notice" do
    expect(flash[:notice]).to eq("Issue was successfully updated.")
  end

  it "Sends a turbo stream response" do
    expect(response.media_type).to eq("text/html")
  end
end