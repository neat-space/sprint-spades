module GameRoomsHelper
  include Rails.application.routes.url_helpers

  def generate_invitation_url(game_room)
    "#{root_url.gsub(/\/$/, '')}/game_rooms/join/#{game_room.token}"
  end
end
