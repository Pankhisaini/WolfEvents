class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :room_location
      t.integer :room_capacity

      t.timestamps
    end
  end
end
