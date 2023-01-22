class GameRoomUsersController < ApplicationController
  # POST /game_rooms/join
  def create
    @game_room = GameRoom.find_by(token: params[:token])

    respond_to do |format|
      if @game_room
        @game_room_user = GameRoomUser.new(game_room: @game_room, user: current_user)
        if @game_room_user.save
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
end
