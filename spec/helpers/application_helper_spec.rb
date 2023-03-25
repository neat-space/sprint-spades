# frozen_string_literal: true

require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#navbar_title" do
    it "returns the name of the game_room" do
      game_room = create(:game_room)
      assign(:game_room, game_room)
      expect(helper.navbar_title).to eq(game_room.name)
    end

    it "returns the name of the application" do
      expect(helper.navbar_title).to eq(helper.application_name)
    end
  end

  describe "#application_name" do
    it "returns the name of the application" do
      expect(helper.application_name).to eq("Sprint Spades")
    end
  end

  describe "#icon" do
    it "returns the icon" do
      expect(helper.icon("fas fa-home")).to eq("<i class=\"fas fa-home\"></i>")
    end
  end

  describe "#link" do
    it "returns the link" do
      expect(helper.link(content: "Home", url: "/")).to eq("<a class=\"\" id=\"\" rel=\"nofollow\" data-method=\"\" href=\"/\">Home</a>")
    end
  end

  describe "#button_text" do
    it "returns the button text" do
      expect(concat helper.button_text(enabled_text: "Create Issue", disabled_text: "Loading...", icon_style: 'fa fa-solid fa-spinner')).to eq("<span class=\"show-when-enabled\">Create Issue</span><span class=\"show-when-disabled\">Loading... <i class=\"fa fa-solid fa-spinner\"></i></span>")
    end
  end
end