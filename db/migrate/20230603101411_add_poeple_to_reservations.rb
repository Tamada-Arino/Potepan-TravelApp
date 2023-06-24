class AddPoepleToReservations < ActiveRecord::Migration[6.1]
  def change
    add_column :reservations, :people, :integer
  end
end
