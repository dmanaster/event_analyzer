class Attending < ActiveRecord::Base
  belongs_to :event
  belongs_to :company
  belongs_to :attendee

  scope :alumni, -> { where(:newbie => false) }
  scope :newbies, -> { where(:newbie => true) }
  scope :attended_previous_year, -> { where(:attended_previous_year => true) }
  scope :attended_previous_season, -> { where(:attended_previous_season => true) }
  scope :attended_both, -> { where(:attended_previous_year => true, :attended_previous_season => true) }
  scope :company_alumni, -> { where(:company_newbie => false) }
  scope :company_newbies, -> { where(:company_newbie => true) }
  scope :company_attended_previous_year, -> { where(:company_attended_previous_year => true) }
  scope :company_attended_previous_season, -> { where(:company_attended_previous_season => true) }
  scope :company_attended_both, -> { where(:company_attended_previous_year => true, :company_attended_previous_season => true) }
end
