namespace :analyzer do
  desc "TODO"
  task import: :environment do
    require 'csv'    
    file_name = Rails.root.join("db", "source", "combined_attendee_list.csv").to_s
    CSV.foreach(file_name, :encoding => 'windows-1251:utf-8', :headers => true) do |row|
      import_event(row[0])
    end
  end
end

def import_event(row)
  event = row.upcase
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
  Event.where(name: event_name, season: event_season, year: event_year).first_or_initialize.save
end