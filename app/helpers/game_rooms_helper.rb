module GameRoomsHelper
  def generate_invitation_url(game_room)
    "#{root_url.gsub(%r{/$}, '')}/game_rooms/join/#{game_room.token}"
  end

  def player_status(user, issue)
    return if issue.nil?

    if user.already_voted?(issue)
      if issue.points_revealed_at
        poker = Poker.find_by(issue:, user:)
        if poker.remarks.present?
          tag.div(class:"d-flex align-items-center justify-content-between") do
            tag.span("Voted with #{pluralize(poker.story_points, 'point')}", class: "badge bg-success") +
            link_to(
              "See Remarks",
              game_room_poker_path(issue.game_room, poker),
              class: "btn btn-sm btn-outline-secondary",
              data: { turbo_frame: "modal" }
            )
          end
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

  def vote_details_helper(poker, issue)
    if poker.persisted?
      { text: "Update Vote", path: edit_game_room_poker_path(issue.game_room, poker) }.with_indifferent_access
    else
      { text: "Vote", path: new_game_room_poker_path(issue.game_room) }.with_indifferent_access
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
