require 'rails_helper'

RSpec.describe "Issues/Revotes#update", type: :request do
  let(:user) { create(:user) }
  let(:game_room) { create(:game_room) }
  let(:issue) { create(:issue, game_room: game_room, points_revealed_at: Time.now) }

  before do
    sign_in user
    user.add_role(:owner, game_room)
  end

  context "when delete previous votes is selected" do
    before do
      create(:poker, issue: issue)
      patch game_room_issue_revotes_path(game_room, issue), params: { issue: { delete_previous_votes: "1" } }
    end

    it "sets the points_revealed_at to nil" do
      expect(issue.reload.points_revealed_at).to be_nil
    end
    
    it "deletes the pokers" do
      expect(issue.pokers.count).to eq(0)
    end
  
    it "redirects to the game_room_url" do
      expect(response).to redirect_to(game_room_url(game_room))
    end
  
    it "sets a flash notice" do
      expect(flash[:notice]).to eq("Issue is open again!")
    end
  end

  context "when delete previous votes is not selected" do
    before do
      create(:poker, issue: issue)
      patch game_room_issue_revotes_path(game_room, issue), params: { issue: { delete_previous_votes: "0" } }
    end

    it "sets the points_revealed_at to nil" do
      expect(issue.reload.points_revealed_at).to be_nil
    end
    
    it "does not delete the pokers" do
      expect(issue.pokers.count).not_to eq(0)
    end
  
    it "redirects to the game_room_url" do
      expect(response).to redirect_to(game_room_url(game_room))
    end
  
    it "sets a flash notice" do
      expect(flash[:notice]).to eq("Issue is open again!")
    end
  end
end