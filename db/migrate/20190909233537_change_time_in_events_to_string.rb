class ChangeTimeInEventsToString < ActiveRecord::Migration[5.2]
  def change
    change_column :events, :event_time, :string
  end
end
