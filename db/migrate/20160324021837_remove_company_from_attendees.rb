class RemoveCompanyFromAttendees < ActiveRecord::Migration
  def change
    remove_column :attendees, :company, :string
  end
end
