class CreatePokers < ActiveRecord::Migration[7.0]
  def change
    create_table :pokers do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :story_points

      t.timestamps
    end
  end
end
