require 'rails_helper'

def destroy
  authorize @game_room_user, :remove_role?
  respond_to do |format|
    if @game_room_user.user.remove_role(:admin, @game_room)
      format.html { redirect_to game_room_url(@game_room), notice: "Succesfully removed #{@game_room_user.name} as an admin." }
      format.json { render :show, status: :created, location: @game_room }
    else
      format.html { redirect_to game_room_url(@game_room), alert: "Something went wrong." }
      format.json { render json: { error: "Something went wrong"}, status: :unprocessable_entity }
    end
  end
end

RSpec.describe "UserRoles#destroy", type: :request do
  let(:user) { create(:user) }
  let(:game_room) { create(:game_room) }
  let(:game_room_user) { create(:game_room_user, game_room: game_room, user: user) }

  before do
    sign_in game_room.creator
  end

  context "when the user's role is successfully removed" do
    before do
      delete game_room_user_roles_path(game_room, game_room_user_id: game_room_user.id)
    end

    it "removes the admin role from the user" do
      expect(game_room_user.user.roles).not_to include(:admin)
    end
  
    it "redirects to the game_room_url" do
      expect(response).to redirect_to(game_room_url(game_room))
    end
  
    it "sets a flash notice" do
      expect(flash[:notice]).to eq("Succesfully removed #{game_room_user.name} as an admin.")
    end
  end

  context "when the user's role is not successfully removed" do
    before do
      allow_any_instance_of(User).to receive(:remove_role).and_return(false)
      delete game_room_user_roles_path(game_room, game_room_user_id: game_room_user.id)
    end

    it "redirects to the game_room_url" do
      expect(response).to redirect_to(game_room_url(game_room))
    end

    it "sets a flash alert" do
      expect(flash[:alert]).to eq("Something went wrong.")
    end
  end
end