class RenameFirstTimeInAttendings < ActiveRecord::Migration
  def change
    rename_column :attendings, :first_time, :newbie
  end
end
