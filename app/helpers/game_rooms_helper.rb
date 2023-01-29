module GameRoomsHelper
  def generate_invitation_url(game_room)
    "#{root_url.gsub(/\/$/, '')}/game_rooms/join/#{game_room.token}"
  end

  def player_action(user, issue)
    return if issue.nil?

    if user.has_already_voted?(issue)
      "Voted"
    else
      "Not voted yet"
    end
  end

  def display_vote_text(issue)
    if current_user.has_already_voted?(issue)
      "Update your vote"
    else
      "Vote"
    end
  end
end
