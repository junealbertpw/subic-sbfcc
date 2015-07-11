class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :category_id, limit: 2
      t.string :title, limit: 250
      t.string :slug, limit: 280
      t.text :content
      t.string :tags, limit: 250
      t.attachment :cover
      t.integer :status, limit: 1
      t.integer :company_id
      t.integer :published_by
      t.datetime :published_at

      t.timestamps null: false
    end
  end
end
