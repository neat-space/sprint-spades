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

  def remove_game_room_user(game_room_user, can_destroy)
    return unless can_destroy

    button_to remove_button_text(game_room_user.user), game_room_game_room_user_path(game_room_user.game_room, game_room_user), method: :delete, data: { confirm: "Are you sure?" }, class: "btn btn-danger"
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
end
