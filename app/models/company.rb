class Company < ActiveRecord::Base
  has_many :attendings
  has_many :events, :through => :attendings
  has_many :attendees, :through => :attendings
end
