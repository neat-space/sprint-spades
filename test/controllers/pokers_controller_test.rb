require "test_helper"

class PokersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @poker = pokers(:one)
  end

  test "should get index" do
    get pokers_url
    assert_response :success
  end

  test "should get new" do
    get new_poker_url
    assert_response :success
  end

  test "should create poker" do
    assert_difference("Poker.count") do
      post pokers_url, params: { poker: { story_points: @poker.story_points, user_id: @poker.user_id } }
    end

    assert_redirected_to poker_url(Poker.last)
  end

  test "should show poker" do
    get poker_url(@poker)
    assert_response :success
  end

  test "should get edit" do
    get edit_poker_url(@poker)
    assert_response :success
  end

  test "should update poker" do
    patch poker_url(@poker), params: { poker: { story_points: @poker.story_points, user_id: @poker.user_id } }
    assert_redirected_to poker_url(@poker)
  end

  test "should destroy poker" do
    assert_difference("Poker.count", -1) do
      delete poker_url(@poker)
    end

    assert_redirected_to pokers_url
  end
end
