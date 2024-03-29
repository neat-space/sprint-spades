class GameRoomUsersController < ApplicationController
  # POST /game_rooms/join
  def create
    @game_room = GameRoom.find_by(token: params[:token])
    respond_to do |format|
      if @game_room
        @game_room_user = GameRoomUser.find_or_initialize_by(game_room: @game_room, user: current_user)

        if @game_room_user.save
          @game_room_user.undiscard if @game_room_user.discarded?
          format.html { redirect_to game_room_url(@game_room), notice: "Invitation successfully accepted!." }
          format.json { render :show, status: :created, location: @game_room }
        else
          format.html { redirect_to root_url, alert: "Something went wrong" }
          format.json { render json: @game_room_user.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to root_url, alert: "Invalid URL." }
        format.json { render json: { errors: "Invalid URL" }, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @game_room_user = GameRoomUser.find(params[:id])
    authorize @game_room_user

    @game_room_user.discard
    respond_to do |format|
      if @game_room_user.user == current_user
        format.html { redirect_to root_url, notice: "You have left the room." }
      else
        format.html { redirect_to game_room_url(@game_room_user.game_room), notice: "User was successfully removed." }        
      end
      format.json { head :no_content }
    end
  end
end
