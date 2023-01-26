module IssuesHelper

  def issue_active?(game_room, issue)
    "active" if issue.id == game_room.current_issue&.id 
  end
end
