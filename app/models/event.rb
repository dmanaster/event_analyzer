class Event < ActiveRecord::Base
  has_many :attendings
  has_many :companies, :through => :attendings
  has_many :attendees, :through => :attendings

  default_scope { order('date ASC') }

  scope :ere, -> { where(name: "ERE") }
  scope :sourcecon, -> { where(name: "Sourcecon") }
end
