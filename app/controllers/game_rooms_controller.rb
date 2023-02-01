class GameRoomsController < ApplicationController
  before_action :set_game_room, only: %i[ show edit update destroy ]

  def index
    @game_rooms = policy_scope(GameRoom)
  end

  def show
  end

  def new
    @game_room = GameRoom.new
  end

  def edit
  end

  def create
    @game_room = current_user.created_game_rooms.new(game_room_params)

    respond_to do |format|
      if @game_room.save
        format.html { redirect_to game_room_url(@game_room), notice: "Game room was successfully created." }
        format.json { render :show, status: :created, location: @game_room }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @game_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /game_rooms/1 or /game_rooms/1.json
  def update
    respond_to do |format|
      if @game_room.update(game_room_params)
        format.html { redirect_to game_room_url(@game_room), notice: "Game room was successfully updated." }
        format.json { render :show, status: :ok, location: @game_room }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @game_room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /game_rooms/1 or /game_rooms/1.json
  def destroy
    @game_room.destroy

    respond_to do |format|
      format.html { redirect_to game_rooms_url, notice: "Game room was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game_room
      @game_room = GameRoom.find(params[:id])
      authorize @game_room
    end

    # Only allow a list of trusted parameters through.
    def game_room_params
      params.require(:game_room).permit(:name)
    end
end
