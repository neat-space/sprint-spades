class AddIndexToPoker < ActiveRecord::Migration[7.0]
  def change
    add_index :pokers, [:user_id, :issue_id], unique: true
  end
end
