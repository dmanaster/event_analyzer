class AddPriorEventsToEvents < ActiveRecord::Migration
  def change
    add_column :events, :previous_year_event, :integer
    add_column :events, :previous_season_event, :integer
  end
end
