require "application_system_test_case"

class PokersTest < ApplicationSystemTestCase
  setup do
    @poker = pokers(:one)
  end

  test "visiting the index" do
    visit pokers_url
    assert_selector "h1", text: "Pokers"
  end

  test "should create poker" do
    visit pokers_url
    click_on "New poker"

    fill_in "Story points", with: @poker.story_points
    fill_in "User", with: @poker.user_id
    click_on "Create Poker"

    assert_text "Poker was successfully created"
    click_on "Back"
  end

  test "should update Poker" do
    visit poker_url(@poker)
    click_on "Edit this poker", match: :first

    fill_in "Story points", with: @poker.story_points
    fill_in "User", with: @poker.user_id
    click_on "Update Poker"

    assert_text "Poker was successfully updated"
    click_on "Back"
  end

  test "should destroy Poker" do
    visit poker_url(@poker)
    click_on "Destroy this poker", match: :first

    assert_text "Poker was successfully destroyed"
  end
end
