class GameRoomsController < ApplicationController
  # POST /game_rooms/join
  def create
    @game_room = GameRoom.find_by(token: params[:token])

    respond_to do |format|
      if @game_room
        GameRoomUser.create!(game_room: @game_room, user: current_user)
        format.html { redirect_to game_room_url(@game_room), notice: "Game room was successfully created." }
        format.json { render :show, status: :created, location: @game_room }
      else
        format.html { redirect_to root_url, alert: "Invalid URL." }
        format.json { render json: { errors: "Invalid URL" }, status: :unprocessable_entity }
      end
    end
  end
end
