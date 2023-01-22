class IssuesController < ApplicationController
  before_action :set_issue, only: %i[ show edit update destroy]
  before_action :set_game_room

  # GET /issues or /issues.json
  def index
    @issues = @game_room.issues.all
  end

  # GET /issues/1 or /issues/1.json
  def show
  end

  # GET /issues/new
  def new
    @issue = Issue.new
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues or /issues.json
  def create
    @issue = @game_room.issues.new(issue_params)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to game_room_url(@game_room), notice: "Issue was successfully created." }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1 or /issues/1.json
  def update
    respond_to do |format|
      if @issue.update(issue_params)
        format.html { redirect_to game_room_issue_url(@game_room, @issue), notice: "Issue was successfully updated." }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1 or /issues/1.json
  def destroy
    @issue.destroy

    @game_room.update(current_issue_id: nil) if @game_room.current_issue_id == @issue.id

    respond_to do |format|
      format.html { redirect_to game_room_issues_url(@game_room), notice: "Issue was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def set_current_issue
    issue = Issue.find(params[:issue_id])
    @game_room.current_issue = issue

    respond_to do |format|
      if @game_room.save!
        format.html { redirect_to game_room_url(@game_room), notice: "Issue was successfully set as current." }
        format.json { render :show, status: :created, location: @game_room }
      else
        format.html { redirect_to game_room_url(@game_room), notice: "Something went wrong." }
        format.json { render json: @game_room.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_issue
      @issue = Issue.find(params[:id])
    end

    def set_game_room
      @game_room = GameRoom.find(params[:game_room_id])
    end

    # Only allow a list of trusted parameters through.
    def issue_params
      params.require(:issue).permit(:title, :description)
    end
end
