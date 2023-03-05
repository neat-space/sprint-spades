# frozen_string_literal: true

class Issues::RevotesController < ApplicationController
  before_action :set_issue, only: %i[new update]
  before_action :set_game_room, only: %i[update]

  def new
  end

  def update
    @issue.update!(points_revealed_at: nil)

    respond_to do |format|
      format.html { redirect_to game_room_url(@game_room), notice: "Issue can be voted again!" }
      format.json { head :no_content }
    end
  end

  private

  def set_issue
    @issue = Issue.find(params[:issue_id])
    authorize @issue, :revote?
  end

  def set_game_room
    @game_room = GameRoom.find(params[:game_room_id])
  end

  # Will be required in the future
  # def revote_params
  #   params.require(:revote).permit(:vote)
  # end
end