class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :title, null: false
    end
    add_index :recipes, :title, unique: true
  end
end
