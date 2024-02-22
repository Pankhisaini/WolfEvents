class AddBelongsToTicket < ActiveRecord::Migration[7.1]
  def change
    add_column :tickets, :belongs_to, :integer
  end
end
