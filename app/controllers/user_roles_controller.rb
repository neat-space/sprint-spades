class UserRolesController < ApplicationController
  before_action :set_game_room, :set_game_room_user, only: [:create, :destroy]

  def create
    authorize @game_room_user, :add_role?
    respond_to do |format|
      if @game_room_user.user.add_role(:admin, @game_room)
        format.html { redirect_to game_room_url(@game_room), notice: "Succesfully added #{@game_room_user.name} as an admin." }
        format.json { render :show, status: :created, location: @game_room }
      else
        format.html { redirect_to game_room_url(@game_room), alert: "Something went wrong." }
        format.json { render json: { error: "Something went wrong"}, status: :unprocessable_entity }
      end
    end
  end

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

  private

    def set_game_room
      @game_room = GameRoom.find(params[:game_room_id])
    end

    def set_game_room_user
      @game_room_user = GameRoomUser.find(params[:game_room_user_id])
    end
end