namespace :analyzer do
  desc "TODO"
  task import: :environment do
    require 'csv'    
    file_name = Rails.root.join("db", "source", "combined_attendee_list.csv").to_s
    CSV.foreach(file_name, :encoding => 'windows-1251:utf-8', :headers => true) do |row|
      event = import_event(row[0])
      company = import_company(row[7])
      attendee = import_attendee(row[2], row[4], row[5], row[9], row[10], row[11], row[12], row[13], row[14], row[15], row[16], row[18])
      create_associations(event, company, attendee)
    end
  end
end

def create_associations(event, company, attendee)
  Attending.create!(:event_id => event.id, :company_id => company.id, :attendee_id => attendee.id)
end

def import_attendee(attendee_first_name, attendee_last_name, attendee_title, attendee_address_1, attendee_address_2, attendee_city, attendee_state, attendee_zip_code, attendee_country, attendee_direct_phone, attendee_mobile_phone, attendee_email)
  new_attendee = Attendee.where(:first_name => attendee_first_name, :last_name =>attendee_last_name, :title => attendee_title, :address_1 => attendee_address_1, :address_2 => attendee_address_2, :city => attendee_city, :state => attendee_state, :zip_code => attendee_zip_code, :country => attendee_country, :direct_phone => attendee_direct_phone, :mobile_phone => attendee_mobile_phone, :email => attendee_email).first_or_initialize
  new_attendee.save
  return new_attendee
end

def import_company(company_name)
  new_company = Company.where(name: company_name).first_or_initialize
  new_company.save
  return new_company
end

def import_event(info)
  event = info.upcase
  if event.include?("ERE")
    event_name = "ERE"
    event = event[3..-1]
  elsif event.include?("SC")
    event_name = "Sourcecon"
    event = event[2..-1]
  end
  if event.include?("SPRING")
    event_season = "spring"
    event.tr!('SPRING', '')
  elsif event.include?("FALL")
    event_season = "fall"
    event.tr!('FALL', '')
  end
  event_year = event
  event_date = set_date(event_name, event_season, event_year)
  new_event = Event.where(name: event_name, season: event_season, year: event_year, date: event_date).first_or_initialize
  new_event.save
  return new_event
end

def set_date(event_name, event_season, event_year)
  if event_name == "ERE" && event_year == "2010" && event_season == "fall"
    event_date = Date.new(2010, 10, 27)
  elsif event_name == "ERE" && event_year == "2010" && event_season == "spring"
    event_date = Date.new(2010, 3, 16)
  elsif event_name == "ERE" && event_year == "2011" && event_season == "fall"
    event_date = Date.new(2011, 9, 7)
  elsif event_name == "ERE" && event_year == "2011" && event_season == "spring"
    event_date = Date.new(2011, 3, 24)
  elsif event_name == "ERE" && event_year == "2012" && event_season == "fall"
    event_date = Date.new(2012, 9, 6)
  elsif event_name == "ERE" && event_year == "2012" && event_season == "spring"
    event_date = Date.new(2012, 3, 28)
  elsif event_name == "ERE" && event_year == "2013" && event_season == "fall"
    event_date = Date.new(2013, 9, 16)
  elsif event_name == "ERE" && event_year == "2013" && event_season == "spring"
    event_date = Date.new(2013, 4, 15)
  elsif event_name == "ERE" && event_year == "2014" && event_season == "fall"
    event_date = Date.new(2014, 9, 16)
  elsif event_name == "ERE" && event_year == "2014" && event_season == "spring"
    event_date = Date.new(2014, 4, 22)
  elsif event_name == "ERE" && event_year == "2015" && event_season == "fall"
    event_date = Date.new(2010, 10, 26)
  elsif event_name == "ERE" && event_year == "2015" && event_season == "spring"
    event_date = Date.new(2015, 4, 27)
  elsif event_name == "Sourcecon" && event_year == "2010" && event_season == "spring"
    event_date = Date.new(2010, 3, 14)
  elsif event_name == "Sourcecon" && event_year == "2010" && event_season == "fall"
    event_date = Date.new(2010, 9, 28)
  elsif event_name == "Sourcecon" && event_year == "2011" && event_season == "spring"
    event_date = Date.new(2011, 2, 8)
  elsif event_name == "Sourcecon" && event_year == "2011" && event_season == "fall"
    event_date = Date.new(2011, 10, 13)
  elsif event_name == "Sourcecon" && event_year == "2012" && event_season == "spring"
    event_date = Date.new(2012, 2, 8)
  elsif event_name == "Sourcecon" && event_year == "2012" && event_season == "fall"
    event_date = Date.new(2012, 9, 20)
  elsif event_name == "Sourcecon" && event_year == "2013" && event_season == "spring"
    event_date = Date.new(2013, 2, 7)
  elsif event_name == "Sourcecon" && event_year == "2013" && event_season == "fall"
    event_date = Date.new(2013, 10, 2)
  elsif event_name == "Sourcecon" && event_year == "2014" && event_season == "spring"
    event_date = Date.new(2014, 2, 24)
  elsif event_name == "Sourcecon" && event_year == "2014" && event_season == "fall"
    event_date = Date.new(2014, 10, 1)
  elsif event_name == "Sourcecon" && event_year == "2015" && event_season == "spring"
    event_date = Date.new(2015, 3, 24)
  elsif event_name == "Sourcecon" && event_year == "2015" && event_season == "fall"
    event_date = Date.new(2015, 10, 26)
  elsif event_name == "Sourcecon" && event_year == "2016" && event_season == "spring"
    event_date = Date.new(2016, 3, 1)
  end
  return event_date
end