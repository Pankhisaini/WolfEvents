class CreateEvents < ActiveRecord::Migration[7.1]
  def change
    create_table :events do |t|
      t.string :event_name
      t.string :event_category
      t.date :event_date
      t.time :event_start_time
      t.time :event_end_time
      t.decimal :ticket_price
      t.integer :number_of_seats_left
      t.references :room, null: false, foreign_key: true

      t.timestamps
    end
  end
end
