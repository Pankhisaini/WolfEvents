class AddNumberOfTickets < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :number_of_tickets, :integer
  end
end
