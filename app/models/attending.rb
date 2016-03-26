class Attending < ActiveRecord::Base
  belongs_to :event
  belongs_to :company
  belongs_to :attendee

  scope :attended_previous_year, -> { where(:attended_previous_year => true) }
  scope :attended_previous_season, -> { where(:attended_previous_season => true) }
  scope :alumni, -> { where(:first_time => false) }
  scope :newbies, -> { where(:first_time => true) }
end
