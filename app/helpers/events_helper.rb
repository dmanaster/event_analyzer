module EventsHelper

  def newbies_count(event)
    return event.attendings.newbies.count
  end

  def alumni_count(event)
    return event.attendings.alumni.count
  end

  def percentage_newbies(event)
    first_time_attendees = newbies_count(event).to_f
    all_attendees = event.attendees.count.to_f
    percentage = number_to_percentage(first_time_attendees/all_attendees*100, precision: 0)
    return percentage
  end

  def percentage_alumni(event)
    alumni_attendees = alumni_count(event).to_f
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

  def company_newbies_count(event)
    return event.attendings.company_newbies.group(:company_id).count.keys.count
  end

  def company_alumni_count(event)
    return event.attendings.company_alumni.group(:company_id).count.keys.count
  end

  def percentage_company_newbies(event)
    first_time_companies = company_newbies_count(event).to_f
    all_companies = event.companies.distinct.count.to_f
    percentage = number_to_percentage(first_time_companies/all_companies*100, precision: 0)
    return percentage
  end

  def percentage_company_alumni(event)
    alumni_companies = company_alumni_count(event).to_f
    all_companies = event.companies.distinct.count.to_f
    percentage = number_to_percentage(alumni_companies/all_companies*100, precision: 0)
    return percentage
  end

end
