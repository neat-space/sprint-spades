require 'rails_helper'

RSpec.describe "Pokers#update", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room, creator: user) }
  let!(:issue) { create(:issue, game_room: game_room) }
  let!(:poker) { create(:poker, user: user, issue: issue) }

  before do
    sign_in user
  end

  context "with valid params" do
    let(:valid_params) { { poker: { story_points: 3, remarks: "some remarks" } } }

    before do
      patch game_room_poker_path(game_room, poker), params: valid_params
    end

    it "updates the requested poker" do
      poker.reload
      expect(poker.story_points).to eq(3)
      expect(poker.remarks).to eq("some remarks")
    end

    it "redirects to the game_room" do
      patch game_room_poker_path(game_room, poker), params: valid_params
      expect(response).to redirect_to(game_room_path(game_room))
    end
  end

  context "with invalid params" do
    let(:invalid_params) do
      {
        poker: {
          story_points: 100
        }
      }
    end

    it "does not update the requested poker" do
      expect {
        patch game_room_poker_path(game_room, poker, format: :turbo_stream), params: invalid_params
      }.not_to change { poker.reload.story_points }
    end

    it "renders the response in turbo stream" do
      patch game_room_poker_path(game_room, poker, format: :turbo_stream), params: invalid_params
      expect(response.media_type).to eq("text/vnd.turbo-stream.html")
      expect(response.body).to include("turbo-stream")
      expect(response.body).to include("form")
    end
  end
end