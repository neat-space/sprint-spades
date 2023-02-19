class FixStoryPointsNotNull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :pokers, :story_points, false, 0
  end
end
