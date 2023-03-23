require 'rails_helper'

def set_current_issue
  issue = Issue.find(params[:issue_id])
  authorize issue
  @game_room.current_issue = issue

  respond_to do |format|
    if @game_room.save!
      format.html { redirect_to game_room_url(@game_room), notice: "Issue was successfully set as current." }
    else
      format.html { redirect_to game_room_url(@game_room), notice: "Something went wrong." }
      format.json { render json: @game_room.errors, status: :unprocessable_entity }
    end
  end
end

RSpec.describe "Issues#set_current_issue", type: :request do
  let(:user) { create(:user) }
  let(:game_room) { create(:game_room) }
  let(:issue) { create(:issue, game_room: game_room) }

  before do
    sign_in user
    user.add_role(:admin, game_room)
    put game_room_issue_set_current_issue_path(game_room, issue)
  end

  it "sets the issue as the current issue" do
    expect(game_room.reload.current_issue).to eq(issue)
  end

  it "redirects to the game_room_url" do
    expect(response).to redirect_to(game_room_url(game_room))
  end

  it "sets a flash notice" do
    expect(flash[:notice]).to eq("Issue was successfully set as current.")
  end
end