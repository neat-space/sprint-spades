require "test_helper"

class GameRoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_room = game_rooms(:one)
  end

  test "should get index" do
    get game_rooms_url
    assert_response :success
  end

  test "should get new" do
    get new_game_room_url
    assert_response :success
  end

  test "should create game_room" do
    assert_difference("GameRoom.count") do
      post game_rooms_url, params: { game_room: { name: @game_room.name, user_id: @game_room.user_id } }
    end

    assert_redirected_to game_room_url(GameRoom.last)
  end

  test "should show game_room" do
    get game_room_url(@game_room)
    assert_response :success
  end

  test "should get edit" do
    get edit_game_room_url(@game_room)
    assert_response :success
  end

  test "should update game_room" do
    patch game_room_url(@game_room), params: { game_room: { name: @game_room.name, user_id: @game_room.user_id } }
    assert_redirected_to game_room_url(@game_room)
  end

  test "should destroy game_room" do
    assert_difference("GameRoom.count", -1) do
      delete game_room_url(@game_room)
    end

    assert_redirected_to game_rooms_url
  end
end
