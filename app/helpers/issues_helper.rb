module IssuesHelper

  def issue_active?(game_room, issue)
    "active" if issue.id == game_room.current_issue&.id 
  end

  def render_average_points(issue)
    return unless issue.points_revealed_at

    content_tag :span, issue.pokers.average(:story_points), class: "badge bg-primary rounded-pill"
  end
end
