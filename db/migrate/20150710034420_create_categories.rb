class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.integer :parent
      t.string :name, limit: 150
      t.string :slug, limit: 180
      t.string :description, limit: 250

      t.timestamps null: false
    end
  end
end
