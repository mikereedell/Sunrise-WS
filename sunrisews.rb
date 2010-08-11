require 'rubygems'
require 'sinatra'
require 'erb'
require 'solareventcalculator'
require 'json'

get '/sunrise/today/:lat/:lng/:tz1/:tz2' do
  timezone = params[:tz1] + '/' + params[:tz2]
  events = events_map(Date.today, BigDecimal.new(params[:lat]), BigDecimal.new(params[:lng]), timezone)

  "#{JSON.generate(date.to_s => events)}"
end

get '/sunrise/year/:lat/:lng/:tz1/:tz2' do
  timezone = params[:tz1] + '/' + params[:tz2]

  dateEvents = Array.new
  Date.new(Date.today.year, 1, 1).upto(Date.new(Date.today.year, 12, 31)) do | date |
    events = events_map(date, BigDecimal.new(params[:lat]), BigDecimal.new(params[:lng]), timezone)
    dateEvents[date.yday - 1] = {date.to_s => events}
  end

  "#{JSON.pretty_generate(dateEvents)}"
end

get '/sunrise/:date/:lat/:lng/:tz1/:tz2' do
  begin
    date = Date.strptime(params[:date], '%F')
  rescue ArgumentError
    halt 500, 'Invalid date format, expected YYYY-MM-DD.'
  end

  timezone = params[:tz1] + '/' + params[:tz2]
  events = events_map(date, BigDecimal.new(params[:lat]), BigDecimal.new(params[:lng]), timezone)
  "#{JSON.pretty_generate(date.to_s => events)}"
end

def events_map(date, lat, lng, timezone)
  calc = SolarEventCalculator.new(date, lat, lng)

  events = {"astronomical_sunrise" => calc.compute_astronomical_sunrise(timezone).strftime('%H:%M:%S %z')}
  events["nautical_sunrise"] = calc.compute_nautical_sunrise(timezone).strftime('%H:%M:%S %z')
  events["official_sunrise"] = calc.compute_official_sunrise(timezone).strftime('%H:%M:%S %z')
  events["civil_sunrise"] = calc.compute_civil_sunrise(timezone).strftime('%H:%M:%S %z')

  events["astronomical_sunset"] = calc.compute_astronomical_sunset(timezone).strftime('%H:%M:%S %z')
  events["nautical_sunset"] = calc.compute_nautical_sunset(timezone).strftime('%H:%M:%S %z')
  events["official_sunset"] = calc.compute_official_sunset(timezone).strftime('%H:%M:%S %z')
  events["civil_sunset"] = calc.compute_civil_sunset(timezone).strftime('%H:%M:%S %z')
  return events
end