class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :address
      add_reference :users, :company, index: true, foreign_key: true
      t.timestamps
    end
  end
end
