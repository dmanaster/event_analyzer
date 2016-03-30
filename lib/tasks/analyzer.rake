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
  puts event.inspect
  if event.name == "ERE"
   newbie = is_ere_newbie?(attendee, event)
    company_newbie = is_ere_newbie?(company, event)
  elsif event.name == "Sourcecon"
    newbie = is_sourcecon_newbie?(attendee, event)
    company_newbie = is_sourcecon_newbie?(company, event)
  end    
  if event.previous_season_event
    previous_season_event = Event.find(event.previous_season_event)
    if attended?(previous_season_event, attendee)
      attended_previous_season = true
    else
      attended_previous_season = false
    end
  end
  if event.previous_year_event
    previous_year_event = Event.find(event.previous_year_event)
    if attended?(previous_year_event, attendee)
      attended_previous_year = true
    else
      attended_previous_year = false
    end
  end
  Attending.create!(:event_id => event.id, :company_id => company.id, :attendee_id => attendee.id, :newbie => newbie, :company_newbie => company_newbie, :attended_previous_season => attended_previous_season, :attended_previous_year => attended_previous_year)
end

def import_attendee(attendee_first_name, attendee_last_name, attendee_title, attendee_address_1, attendee_address_2, attendee_city, attendee_state, attendee_zip_code, attendee_country, attendee_direct_phone, attendee_mobile_phone, attendee_email)
  if attendee_first_name
    titleized_first_name = attendee_first_name.titleize
  else
    titleized_first_name = attendee_first_name
  end
  if attendee_last_name
    titleized_last_name = attendee_last_name.titleize
  else
    titleized_last_name = attendee_last_name
  end

  new_attendee = Attendee.where(:first_name => titleized_first_name, :last_name =>titleized_last_name).first_or_initialize
  new_attendee.save
  return new_attendee
end

def import_company(company_name)
  if company_name
    titleized_company_name = company_name.titleize
  else
    titleized_company_name = company_name
  end

  new_company = Company.where(name: titleized_company_name).first_or_initialize
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
  event_count = Event.where('date < ?', event_date).where(:name => event_name).size

  unless Event.exists?(name: event_name, season: event_season, year: event_year)
    if event_count == 0
      new_event = Event.where(name: event_name, season: event_season, year: event_year, date: event_date).first_or_initialize    
    elsif event_count == 1
      previous_season_event = Event.where('date < ?', event_date).where(:name => event_name).order(date: :asc).last.id
      new_event = Event.where(name: event_name, season: event_season, year: event_year, date: event_date, previous_season_event: previous_season_event).first_or_initialize
    else
      previous_year_event = Event.where('date < ?', event_date).where(:name => event_name, :season => event_season).order(date: :asc).last.id
      previous_season_event = Event.where('date < ?', event_date).where(:name => event_name).order(date: :asc).last.id
      new_event = Event.where(name: event_name, season: event_season, year: event_year, date: event_date, previous_year_event: previous_year_event, previous_season_event: previous_season_event).first_or_initialize
    end
    new_event.save
  else
    new_event = Event.where(name: event_name, season: event_season, year: event_year).first
  end
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
    event_date = Date.new(2015, 10, 26)
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

def attended?(event, attendee)
  event.attendees.include?(attendee)
end

def is_sourcecon_newbie?(attendee, event)
  if (attendee.events.sourcecon.count > 0) && (attendee.events.sourcecon.first.date < event.date)
    newbie = false
  else
    newbie = true
  end
  return newbie
end

def is_ere_newbie?(attendee, event)
  if (attendee.events.ere.count > 0) && (attendee.events.ere.first.date < event.date)
    newbie = false
  else
    newbie = true
  end
  return newbie
end