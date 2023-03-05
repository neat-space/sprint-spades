class PokersController < ApplicationController
  before_action :set_poker, only: %i[ update destroy show]
  before_action :set_game_room


  def new
    @poker = Current.user.pokers.new(issue: @game_room.current_issue)
    @issue = @game_room.current_issue
    authorize @poker
  end

  def create
    @poker = Current.user.pokers.new(poker_params)
    @poker.issue = @game_room.current_issue
    authorize @poker

    respond_to do |format|
      if @poker.save
        format.html { redirect_to game_room_path(@game_room), notice: "You have successfully voted." }
      else
        format.turbo_stream
      end
    end
  end

  def show
    authorize @poker
  end

  def update
    respond_to do |format|
      if @poker.update(poker_params)
        format.html { redirect_to game_room_path(@game_room), notice: "Vote updated!" }
      else
        format.turbo_stream
      end
    end
  end

  def destroy
    @poker.destroy

    respond_to do |format|
      format.html { redirect_to game_room_path(@game_room), notice: "Cleared your vote!" }
      format.json { head :no_content }
    end
  end

  private
    def set_poker
      @poker = Poker.find(params[:id])
      authorize @poker
    end

    def set_game_room
      @game_room = GameRoom.find(params[:game_room_id])
    end

    def poker_params
      params.require(:poker).permit(:story_points, :remarks)
    end
end
