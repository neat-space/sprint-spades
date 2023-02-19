# frozen_string_literal: true

class FixAverageStoryPoints < ActiveRecord::Migration[7.0]
  def up
    Issue.find_each do |issue|
      issue.update(pokers_count: issue.pokers.count, average_story_points: issue.pokers.average(:story_points)) if issue.pokers.any?
    end

    FixAverageStoryPointsVerifier.new.verify
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

class FixAverageStoryPointsVerifier
  def verify
    Issue.find_each do |issue|
      if issue.pokers.any?
        if issue.average_story_points != issue.pokers.average(:story_points)
          raise "Average story points for issue #{issue.id} is incorrect"
        end
        if issue.pokers_count != issue.pokers.count
          raise "Pokers count for issue #{issue.id} is incorrect"
        end
      end
    end
  end
end
