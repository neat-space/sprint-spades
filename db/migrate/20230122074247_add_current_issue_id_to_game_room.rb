class AddCurrentIssueIdToGameRoom < ActiveRecord::Migration[7.0]
  def change
    add_column :game_rooms, :current_issue_id, :integer
    add_index :game_rooms, :current_issue_id
  end
end
