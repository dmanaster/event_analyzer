class Attendee < ActiveRecord::Base
  has_many :attendings
  has_many :companies, :through => :attendings
  has_many :events, :through => :attendings
end
