class AddFirstTimeToAttending < ActiveRecord::Migration
  def change
    add_column :attendings, :first_time, :boolean
  end
end
