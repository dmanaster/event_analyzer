module EventsHelper

  def percentage_newbies(event)
    first_time_attendees = event.attendings.newbies.count.to_f
    all_attendees = event.attendees.count.to_f
    percentage = number_to_percentage(first_time_attendees/all_attendees*100, precision: 0)
    return percentage
  end

  def percentage_alumni(event)
    alumni_attendees = event.attendings.alumni.count.to_f
    all_attendees = event.attendees.count.to_f
    percentage = number_to_percentage(alumni_attendees/all_attendees*100, precision: 0)
    return percentage
  end

  def percentage_previous_year(event)
    prior_attendees = event.attendings.attended_previous_year.count.to_f
    all_attendees = event.attendees.count.to_f
    percentage = number_to_percentage(prior_attendees/all_attendees*100, precision: 0)
    return percentage
  end

  def percentage_previous_season(event)
    prior_attendees = event.attendings.attended_previous_season.count.to_f
    all_attendees = event.attendees.count.to_f
    percentage = number_to_percentage(prior_attendees/all_attendees*100, precision: 0)
    return percentage
  end

end
