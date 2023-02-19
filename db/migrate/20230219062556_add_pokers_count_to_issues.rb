class AddPokersCountToIssues < ActiveRecord::Migration[7.0]
  def change
    add_column :issues, :pokers_count, :integer, null: false, default: 0
  end
end
