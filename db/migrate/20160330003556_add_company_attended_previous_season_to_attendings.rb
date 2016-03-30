class AddCompanyAttendedPreviousSeasonToAttendings < ActiveRecord::Migration
  def change
    add_column :attendings, :company_attended_previous_season, :boolean
  end
end
