module GameRoomsHelper
  include Rails.application.routes.url_helpers

  def generate_invitation_url(game_room)
    "#{root_url.gsub(/\/$/, '')}/game_rooms/join/#{game_room.token}"
  end

  def player_action(user, issue)
    return if issue.nil?

    if user.id == current_user.id
      render_voting_action(user, issue)
    else
      render_voting_status(user, issue)
    end
  end

  private
  
    def render_voting_action(user, issue)
      if user.has_already_voted?(issue)
        render "pokers/components/vote", poker: Poker.find_by(issue: issue, user: user), issue: issue, user: user
      else
        render "pokers/components/vote", poker: Poker.new(issue: issue, user: user), issue: issue, user: user
      end
    end
    
    def render_voting_status(user, issue)
      if user.has_already_voted?(issue)
        "Voted"
      else
        "Not voted yet"
      end
    end
end
