class Attending < ActiveRecord::Base
  belongs_to :event
  belongs_to :company
  belongs_to :attendee
end
