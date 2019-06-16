class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest, null: false
      t.string :employee_id
      t.string :name
      t.integer :role_type
      t.timestamps
    end
  end
end
