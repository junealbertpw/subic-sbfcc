class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :member_type, limit: 2
      t.string :name, limit: 180
      t.string :slug, limit: 200
      t.integer :user_id
      t.text :website
      t.text :description
      t.string :fax, limit: 100
      t.string :phone, limit: 100
      t.string :email, limit: 150
      t.string :address, limit: 300
      t.integer :status, limit: 1
      t.attachment :cover

      t.timestamps null: false
    end
  end
end
