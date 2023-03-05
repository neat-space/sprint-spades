class MigrateIssueDescriptionToActionText < ActiveRecord::Migration[7.0]
  include ActionView::Helpers::TextHelper
  
  def change
    rename_column :issues, :description, :description_old
    Issue.find_each do |issue|
      issue.update_attribute(:description, simple_format(issue.description_old))
    end
    remove_column :issues, :description_old
  end
end
