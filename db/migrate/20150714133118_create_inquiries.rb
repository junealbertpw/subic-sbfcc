class CreateInquiries < ActiveRecord::Migration
  def change
    create_table :inquiries do |t|
      t.string :first_name, limit: 150
      t.string :last_name, limit: 150
      t.string :email, limit: 180
      t.string :phone, limit: 100
      t.text :message

      t.timestamps null: false
    end
  end
end
