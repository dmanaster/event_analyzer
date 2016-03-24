class RenameTypeInEventsToName < ActiveRecord::Migration
  def change
    rename_column :events, :type, :name
  end
end
