json.array!(@attendees) do |attendee|
  json.extract! attendee, :id, :first_name, :last_name, :title, :company, :address_1, :address_2, :city, :state, :zip_code, :country, :direct_phone, :mobile_phone, :email
  json.url attendee_url(attendee, format: :json)
end
