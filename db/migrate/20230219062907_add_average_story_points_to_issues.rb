class AddAverageStoryPointsToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :average_story_points, :float, null: false, default: 0.0
  end
end
