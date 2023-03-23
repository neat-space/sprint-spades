# frozen_string_literal: true

require "rails_helper"

RSpec.describe IssuesHelper, type: :helper do
  describe "#issue_active?" do
    let!(:game_room) { create(:game_room) }
    let!(:issue) { create(:issue, game_room: game_room) }

    context "when issue is the current issue" do
      before do
        game_room.update(current_issue: issue)
      end

      it "returns active" do
        expect(helper.issue_active?(game_room, issue)).to eq("active")
      end
    end

    context "when issue is not the current issue" do
      before do
        game_room.update(current_issue: create(:issue))
      end

      it "returns nil" do
        expect(helper.issue_active?(game_room, issue)).to be_nil
      end
    end
  end

  describe "#render_average_points" do
    let(:issue) { create(:issue) }

    context "when points are not revealed" do
      it "returns nil" do
        expect(helper.render_average_points(issue)).to be_nil
      end
    end

    context "when points are revealed" do
      before do
        issue.update(points_revealed_at: Time.now)
      end

      it "returns the average points" do
        expect(helper.render_average_points(issue)).to eq(tag.span(issue.average_story_points, class: "badge bg-primary rounded-pill"))
      end
    end
  end
end