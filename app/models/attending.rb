class Attending < ActiveRecord::Base
  belongs_to :event
  belongs_to :company
  belongs_to :attendee

  scope :attended_previous_year, -> { where(:attended_previous_year => true) }
  scope :attended_previous_season, -> { where(:attended_previous_season => true) }
end
