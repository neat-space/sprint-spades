module GameRoomsHelper
  def generate_invitation_url(game_room)
    "#{root_url.gsub(/\/$/, '')}/game_rooms/join/#{game_room.token}"
  end

  def player_status(user, issue)
    return if issue.nil?

    if user.already_voted?(issue)
      issue.points_revealed_at ? "Voted with #{user.points_for(issue)} points" : "Voted"
    else
      issue.points_revealed_at ? "Didn't vote" : "Not voted yet"
    end
  end

  def display_vote_text(issue)
    if Current.user.already_voted?(issue)
      "Update your vote"
    else
      "Vote"
    end
  end
end
