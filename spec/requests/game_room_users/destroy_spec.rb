# frozen_string_literal: true

require 'rails_helper'

# def destroy
#   @game_room_user = GameRoomUser.find(params[:id])
#   authorize @game_room_user

#   @game_room_user.discard
#   respond_to do |format|
#     if @game_room_user.user == current_user
#       format.html { redirect_to root_url, notice: "You have left the room." }
#     else
#       format.html { redirect_to game_room_url(@game_room_user.game_room), notice: "User was successfully removed." }        
#     end
#     format.json { head :no_content }
#   end
# end

RSpec.describe "GameRoomUsers#destroy", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room) }
  let!(:game_room_user) { create(:game_room_user, game_room:, user:) }

  before do
    sign_in user
  end

  context "when game_room_user is the current user" do
    it "discards the game_room_user" do
      expect {
        delete game_room_game_room_user_path(game_room, game_room_user)
      }.to change { game_room_user.reload.discarded? }.from(false).to(true)
    end

    it "redirects to the root url" do
      delete game_room_game_room_user_path(game_room, game_room_user)
      expect(response).to redirect_to root_url
    end

    it "sets the flash notice" do
      delete game_room_game_room_user_path(game_room, game_room_user)
      expect(flash[:notice]).to eq "You have left the room."
    end
  end

  context "when game_room_user is not the current user" do
    before do
      game_room_user.update(user: create(:user))
      user.add_role :owner, game_room
    end

    it "discards the game_room_user" do
      expect {
        delete game_room_game_room_user_path(game_room, game_room_user)
      }.to change { game_room_user.reload.discarded? }.from(false).to(true)
    end

    it "redirects to the game room" do
      delete game_room_game_room_user_path(game_room, game_room_user)
      expect(response).to redirect_to game_room_path(game_room)
    end

    it "sets the flash notice" do
      delete game_room_game_room_user_path(game_room, game_room_user)
      expect(flash[:notice]).to eq "User was successfully removed."
    end
  end
end