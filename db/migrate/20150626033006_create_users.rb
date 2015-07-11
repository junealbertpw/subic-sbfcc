class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :company_id
      t.string :email, limit: 150
      t.string :password, limit: 65
      t.string :first_name, limit: 50
      t.string :last_name, limit: 50
      t.string :position, limit: 75
      t.integer :role, limit: 1
      t.integer :status, limit: 1
      t.string :recovery_uid, limit: 65
      t.datetime :recovery_at

      t.timestamps null: false
    end
  end
end
