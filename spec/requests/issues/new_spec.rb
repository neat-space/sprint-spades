# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Issues#new", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room) }
  let!(:game_room_user) { create(:game_room_user, game_room: game_room, user: user) }

  before do
    sign_in user
    user.add_role :admin, game_room
  end

  it "initializes a new issue" do
    get new_game_room_issue_path(game_room)
    expect(assigns(:issue)).to be_a_new(Issue)
  end

  it "is successful" do
    get new_game_room_issue_path(game_room)
    expect(response).to be_successful
  end
end