# frozen_string_literal: true

class Issues::RevotesController < ApplicationController
  before_action :set_issue, only: %i[new update]

  def new
  end

  def update
    @issue.update!(points_revealed_at: nil)
    @issue.pokers.destroy_all if params[:issue][:delete_previous_votes] == "1"

    respond_to do |format|
      format.html { redirect_to game_room_url(@issue.game_room), notice: "Issue is open again!" }
      format.json { head :no_content }
    end
  end

  private

  def set_issue
    @issue = Issue.find(params[:issue_id])
    authorize @issue, :revote?
  end
end
