class Issues::RevealVotesController < ApplicationController
  before_action :set_issue, only: %i[new update]
  
  def new
  end

  def update
    @issue.update(points_revealed_at: Time.current)

    respond_to do |format|
      format.html { redirect_to game_room_url(@issue.game_room), notice: "Points revealed!" }
      format.json { head :no_content }
    end
  end

  private

  def set_issue
    @issue = Issue.find(params[:issue_id])
    authorize @issue, :reveal_votes?
  end
end