module EventsHelper

  def all_attendees_count(event)
    return event.attendees.count
  end

  def newbies_count(event)
    return event.attendings.newbies.count
  end

  def alumni_count(event)
    return event.attendings.alumni.count
  end

  def previous_year_count(event)
    return event.attendings.attended_previous_year.count
  end

  def previous_season_count(event)
    return event.attendings.attended_previous_season.count
  end

  def percentage_newbies(event)
    first_time_attendees = newbies_count(event).to_f
    all_attendees = all_attendees_count(event).to_f
    percentage = number_to_percentage(first_time_attendees/all_attendees*100, precision: 0)
    return percentage
  end

  def percentage_alumni(event)
    alumni_attendees = alumni_count(event).to_f
    all_attendees = all_attendees_count(event).to_f
    percentage = number_to_percentage(alumni_attendees/all_attendees*100, precision: 0)
    return percentage
  end

  def percentage_previous_year(event)
    prior_attendees = previous_year_count(event).to_f
    all_attendees = all_attendees_count(event).to_f
    percentage = number_to_percentage(prior_attendees/all_attendees*100, precision: 0)
    return percentage
  end

  def percentage_previous_season(event)
    prior_attendees = previous_season_count(event).to_f
    all_attendees = all_attendees_count(event).to_f
    percentage = number_to_percentage(prior_attendees/all_attendees*100, precision: 0)
    return percentage
  end

  def all_companies_count(event)
    return event.companies.distinct.count
  end

  def company_newbies_count(event)
    return event.attendings.company_newbies.group(:company_id).count.keys.count
  end

  def company_alumni_count(event)
    return event.attendings.company_alumni.group(:company_id).count.keys.count
  end

  def percentage_company_newbies(event)
    first_time_companies = company_newbies_count(event).to_f
    all_companies = all_companies_count(event).to_f
    percentage = number_to_percentage(first_time_companies/all_companies*100, precision: 0)
    return percentage
  end

  def percentage_company_alumni(event)
    alumni_companies = company_alumni_count(event).to_f
    all_companies = all_companies_count(event).to_f
    percentage = number_to_percentage(alumni_companies/all_companies*100, precision: 0)
    return percentage
  end

# To be removed once numbers are checked

  def both_count(event)
    return event.attendings.attended_both.count
  end

  def percentage_both(event)
    prior_attendees = both_count(event).to_f
    all_attendees = all_attendees_count(event).to_f
    percentage = number_to_percentage(prior_attendees/all_attendees*100, precision: 0)
    return percentage
  end

end
