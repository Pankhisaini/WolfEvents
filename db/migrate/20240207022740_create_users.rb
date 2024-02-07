class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :name
      t.string :phone_number
      t.string :address
      t.string :credit_card_information

      t.timestamps
    end
  end
end
