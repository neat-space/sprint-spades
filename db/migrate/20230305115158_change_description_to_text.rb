class ChangeDescriptionToText < ActiveRecord::Migration[7.0]
  def up
    change_column :issues, :description, :text
  end
  def down
    # This might cause trouble if you have strings longer
    # than 255 characters.
    change_column :issues, :description, :string
  end
end
