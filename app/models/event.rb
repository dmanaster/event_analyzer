class Event < ActiveRecord::Base
  has_many :attendings
  has_many :companies, :through => :attendings
  has_many :attendees, :through => :attendings
end
