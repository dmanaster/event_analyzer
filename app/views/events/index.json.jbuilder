json.array!(@events) do |event|
  json.extract! event, :id, :year, :season
  json.url event_url(event, format: :json)
end
