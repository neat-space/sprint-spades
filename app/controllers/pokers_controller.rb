class PokersController < ApplicationController
  before_action :set_poker, only: %i[ show edit update destroy ]
  before_action :set_game_room

  # GET /pokers or /pokers.json
  def index
    @pokers = Poker.all
  end

  # GET /pokers/1 or /pokers/1.json
  def show
  end

  # GET /pokers/new
  def new
    @poker = Poker.new
  end

  # GET /pokers/1/edit
  def edit
  end

  # POST /pokers or /pokers.json
  def create
    @poker = current_user.pokers.new(poker_params)
    @poker.issue = @game_room.current_issue

    respond_to do |format|
      if @poker.save
        format.html { redirect_to game_room_url(@game_room), notice: "You have successfully voted." }
        format.json { render :show, status: :created, location: @poker }
      else
        format.turbo_stream
      end
    end
  end

  # PATCH/PUT /pokers/1 or /pokers/1.json
  def update
    respond_to do |format|
      if @poker.update(poker_params)
        format.html { redirect_to game_room_url(@game_room), notice: "Your vote was successfully updated." }
        format.json { render :show, status: :ok, location: @poker }
      else
        format.turbo_stream
      end
    end
  end

  # DELETE /pokers/1 or /pokers/1.json
  def destroy
    @poker.destroy

    respond_to do |format|
      format.html { redirect_to game_room_pokers_url(@game_room), notice: "Poker was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_poker
      @poker = Poker.find(params[:id])
    end

    def set_game_room
      @game_room = GameRoom.find(params[:game_room_id])
    end

    # Only allow a list of trusted parameters through.
    def poker_params
      params.require(:poker).permit(:story_points)
    end
end
