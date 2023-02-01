class IssuesController < ApplicationController
  include ActionView::RecordIdentifier

  before_action :set_issue, only: %i[ update destroy]
  before_action :set_game_room

  def create
    @issue = @game_room.issues.new(issue_params)
    authorize @issue

    respond_to do |format|
      if @issue.save
        format.html { redirect_to game_room_url(@game_room), notice: "Issue was successfully created." }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("issue-form-#{dom_id(@issue)}", partial: "issues/form", locals: { game_room: @game_room, issue: @issue })
        end
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to game_room_url(@game_room), notice: "Issue was successfully updated." }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("issue-form-#{dom_id(@issue)}", partial: "issues/form", locals: { game_room: @game_room, issue: @issue })
        end
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @issue.destroy

    respond_to do |format|
      format.html { redirect_to game_room_url(@game_room), notice: "Issue was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def set_current_issue
    issue = Issue.find(params[:issue_id])
    authorize issue
    @game_room.current_issue = issue

    respond_to do |format|
      if @game_room.save!
        format.html { redirect_to game_room_url(@game_room), notice: "Issue was successfully set as current." }
      else
        format.html { redirect_to game_room_url(@game_room), notice: "Something went wrong." }
        format.json { render json: @game_room.errors, status: :unprocessable_entity }
      end
    end
  end

  def reveal_votes
    issue = Issue.find(params[:issue_id])
    authorize issue

    issue.update!(points_revealed_at: Time.current)

    respond_to do |format|
      format.html { redirect_to game_room_url(@game_room), notice: "Points revealed!" }
      format.json { head :no_content }
    end
  end

  private

    def set_issue
      @issue = Issue.find(params[:id])
      authorize @issue
    end

    def set_game_room
      @game_room = GameRoom.find(params[:game_room_id])
    end

    def issue_params
      params.require(:issue).permit(:title, :description)
    end
end
