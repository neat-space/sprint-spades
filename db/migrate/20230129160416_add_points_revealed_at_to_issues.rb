class AddPointsRevealedAtToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :points_revealed_at, :datetime
  end
end
