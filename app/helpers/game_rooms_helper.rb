module GameRoomsHelper
  def generate_invitation_url(game_room)
    "#{root_url.gsub(/\/$/, '')}/game_rooms/join/#{game_room.token}"
  end

  def player_status(user, issue)
    return if issue.nil?

    if user.already_voted?(issue)
      if issue.points_revealed_at
        poker = Poker.find_by(issue: issue, user: user)

        if poker.remarks.present?
          link_to "Voted with #{poker.story_points} points", game_room_poker_path(issue.game_room, poker), class: "btn btn-sm btn-outline-primary", data: { turbo_frame: "modal" }
        else
          tag.span("Voted with #{poker.story_points} points", class: "badge bg-success")
        end
      else
        tag.span("Voted", class: "badge bg-success")
      end

    else
      issue.points_revealed_at ? tag.span("Didn't vote", class: "badge bg-secondary") : tag.span("Not voted", class: 'badge bg-secondary')
    end
  end

  def display_vote_text(issue)
    if Current.user.already_voted?(issue)
      "Update your vote"
    else
      "Vote"
    end
  end

  private

  def remove_button_text(user)
    if user == Current.user
      "Leave room"
    else
      "Remove Player"
    end
  end

  def confirm_remove_text(user)
    if user == Current.user
      "Are you sure you want to leave the room?"
    else
      "Are you sure you want to remove this player?"
    end
  end
end
