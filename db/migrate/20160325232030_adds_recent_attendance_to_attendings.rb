class AddsRecentAttendanceToAttendings < ActiveRecord::Migration
  def change
    add_column :attendings, :attended_previous_year, :boolean
    add_column :attendings, :attended_previous_season, :boolean
  end
end
