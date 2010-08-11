require File.dirname(__FILE__) + '/spec_helper'

describe 'Sunrise Web Services' do
  include Rack::Test::Methods

  def app
    @app ||= Sinatra::Application
  end

  it "At least 365 event maps of 8 times are returned when processing an entire year" do
    get '/sunrise/year/39.9537/-75.8301537/America/New_York'
    last_response.should be_ok
    events = JSON.parse(last_response.body)
    events.should have_at_least(365).items

    events.each do | event |
      event.keys.size.should eql(1)
      event[event.keys[0]].size.should eql(8)
    end
  end

  it "Should return an error when an invalid date format is passed in" do
    get '/sunrise/20081101/39.9537/-75.8301537/America/New_York'
    last_response.status.should eql(500)
    last_response.body.should eql('Invalid date format, expected YYYY-MM-DD.')
  end

  it "Should return the proper set of sunrise/sunset times for a given date, lat/lng, and timezone" do
    get '/sunrise/2008-11-01/39.9537/-75.7850/America/New_York'
    last_response.should be_ok
    data = JSON.parse(last_response.body)
    data.should have_exactly(1).items

    events = data['2008-11-01']
    events['astronomical_sunrise'].should eql('06:01:00 -0400')
    events['nautical_sunrise'].should eql('06:32:00 -0400')
    events['civil_sunrise'].should eql('07:04:00 -0400')
    events['official_sunrise'].should eql('07:33:00 -0400')

    events['official_sunset'].should eql('17:59:00 -0400')
    events['civil_sunset'].should eql('18:28:00 -0400')
    events['nautical_sunset'].should eql('19:00:00 -0400')
    events['astronomical_sunset'].should eql('19:31:00 -0400')
  end

  it "Should return a set of sunrise/sunset data for today" do
    get '/sunrise/today/39.9537/-75.8301537/America/New_York'
    last_response.should be_ok
    data = JSON.parse(last_response.body)
    data.should have_exactly(1).items

    data.keys[0].should eql(Date.today.to_s)
  end
end