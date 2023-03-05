class AddRemarksToPokers < ActiveRecord::Migration[7.0]
  def change
    add_column :pokers, :remarks, :text
  end
end
