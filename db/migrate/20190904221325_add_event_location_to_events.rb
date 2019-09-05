class AddEventLocationToEvents < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :event_location, :string
  end
end
