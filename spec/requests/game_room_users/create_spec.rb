# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "GameRoomUsers#create", type: :request do
  let!(:user) { create(:user) }
  let!(:game_room) { create(:game_room) }
  let(:game_room_user) { create(:game_room_user, game_room:, user:) }

  before do
    sign_in user
  end

  context "when user is not a member of the game room" do
    it "creates a new game room user" do
      expect {
        get "/game_rooms/join/#{game_room.token}"
      }.to change(GameRoomUser, :count).by(1)
    end

    it "redirects to the game room" do
      get "/game_rooms/join/#{game_room.token}"
      expect(response).to redirect_to game_room_path(game_room)
    end

    it "sets the flash notice" do
      get "/game_rooms/join/#{game_room.token}"
      expect(flash[:notice]).to eq "Invitation successfully accepted!."
    end
  end

  context "when user is already a member of the game room" do
    before do
      game_room_user
    end

    it "does not create a new game room user" do
      expect {
        get "/game_rooms/join/#{game_room.token}"
      }.not_to change(GameRoomUser, :count)
    end

    it "redirects to the game room" do
      get "/game_rooms/join/#{game_room.token}"
      expect(response).to redirect_to game_room_path(game_room)
    end

    it "sets the flash notice" do
      get "/game_rooms/join/#{game_room.token}"
      expect(flash[:notice]).to eq "Invitation successfully accepted!."
    end
  end

  context "when user is already a member of the game room but has been discarded" do
    before do
      game_room_user.discard
    end

    it "undiscards the game room user" do
      get "/game_rooms/join/#{game_room.token}"
      expect(game_room_user.reload.discarded?).to be_falsy
    end

    it "does not create a new game room user" do
      expect {
        get "/game_rooms/join/#{game_room.token}"
      }.not_to change(GameRoomUser, :count)
    end

    it "redirects to the game room" do
      get "/game_rooms/join/#{game_room.token}"
      expect(response).to redirect_to game_room_path(game_room)
    end

    it "sets the flash notice" do
      get "/game_rooms/join/#{game_room.token}"
      expect(flash[:notice]).to eq "Invitation successfully accepted!."
    end

  end

  context "when game_room_user is invalid" do
    before do
      allow_any_instance_of(GameRoomUser).to receive(:save).and_return(false)
    end

    it "does not create a new game room user" do
      expect {
        get "/game_rooms/join/#{game_room.token}"
      }.not_to change(GameRoomUser, :count)
    end

    it "redirects to the root url" do
      get "/game_rooms/join/#{game_room.token}"
      expect(response).to redirect_to root_url
    end

    it "sets the flash alert" do
      get "/game_rooms/join/#{game_room.token}"
      expect(flash[:alert]).to eq "Something went wrong"
    end
  end

  context "when game room does not exist" do
    
    it "redirects to the root url" do
      get "/game_rooms/join/invalid-token"
      expect(response).to redirect_to root_url
    end

    it "sets the flash alert" do
      get "/game_rooms/join/invalid-token"
      expect(flash[:alert]).to eq "Invalid URL."
    end
  end
end