module EventsHelper

  def count_first_timers(event)
    return event.attendings.where(first_time: true).count
  end

  def percentage_first_timers(event)
    first_time_attendees = event.attendings.where(first_time: true).count.to_f
    all_attendees = event.attendees.count.to_f
    percentage = number_to_percentage(first_time_attendees/all_attendees*100, precision: 0)
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
