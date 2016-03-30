class AddCompanyAttendedPreviousYearToAttendings < ActiveRecord::Migration
  def change
    add_column :attendings, :company_attended_previous_year, :boolean
  end
end
