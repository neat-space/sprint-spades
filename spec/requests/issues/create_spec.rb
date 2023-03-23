# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Issues#create", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room) }
  let!(:game_room_user) { create(:game_room_user, game_room: game_room, user: user) }

  before do
    sign_in user
    user.add_role :admin, game_room
  end

  it "creates a new issue" do
    expect do
      post game_room_issues_path(game_room), params: { issue: { title: "New Issue" } }
    end.to change(Issue, :count).by(1)
  end

  it "redirects to the game_room_url" do
    post game_room_issues_path(game_room), params: { issue: { title: "New Issue" } }
    expect(response).to redirect_to(game_room_url(game_room))
  end

  it "sets a flash notice" do
    post game_room_issues_path(game_room), params: { issue: { title: "New Issue" } }
    expect(flash[:notice]).to eq("Issue was successfully created.")
  end

  it "Sends a turbo stream response" do
    post game_room_issues_path(game_room), params: { issue: { title: "New Issue" } }
    expect(response.media_type).to eq("text/html")
  end
end