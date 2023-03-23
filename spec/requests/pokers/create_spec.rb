require 'rails_helper'

RSpec.describe "Pokers#create", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room, creator: user) }
  let!(:issue) { create(:issue, game_room: game_room) }

  before do
    sign_in user
  end
  
  context "when the poker is valid" do
    before do
      post game_room_pokers_path(game_room), params: { poker: { story_points: 1, remarks: "Some Remarks" } }
    end

    it "creates a poker" do
      expect(Poker.count).to eq(1)
    end

    it "redirects to the game_room_url" do
      expect(response).to redirect_to(game_room_url(game_room))
    end

    it "sets a flash notice" do
      expect(flash[:notice]).to eq("You have successfully voted.")
    end
  end

  context "when the poker is invalid" do
    before do
      post game_room_pokers_path(game_room, format: :turbo_stream), params: { poker: { story_points: nil, remarks: "Some Remarks" } }
    end

    it "does not create a poker" do
      expect(Poker.count).to eq(0)
    end

    it "renders response in turbo stream" do
      expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      expect(response.body).to include("turbo-stream")
      expect(response.body).to include("form")
    end
  end
end