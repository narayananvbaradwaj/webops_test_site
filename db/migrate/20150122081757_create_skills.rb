class CreateSkills < ActiveRecord::Migration
  def change
    create_table :skills do |t|
      t.string :name
      t.string :link
      t.string :image_name
      t.string :category
      t.string :sub_category

      t.timestamps null: false
    end
  end
end
