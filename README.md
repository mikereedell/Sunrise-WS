Sunrise-WS
==========

Super simple Sinatra wrapper around the RubySunrise gem to provide sunrise/sunset data using JSON web-services.

Description
-----------



Dependencies
------------
From the .gems file:
 - sinatra 1.0
 - RubySunrise 0.2
 - json 1.4.3
 - tzinfo 0.3.17


Installation
------------

	% git clone git://github.com/mikereedell/Sunrise-WS.git
	% cd Sunrise-WS
	% ruby sunrisews.rb

That's it!


Usage
-----

There are just a handful of services provided:
 - Get all sunrise/sunset data for today.
 - Get all sunrise/sunset data this year.
 - Get all sunrise/sunset data a specific date.

And by all sunrise/sunset data, there are four types:
 - Official rise/set occurs when the sun is at 90deg, 50minutes.
 - Civil rise/set (commonly referred to as twilight) occurs when the sun is at 96deg (six degrees below the horizon).
 - Nautical rise/set occurs when the sun is at 102deg.
 - Astronomical rise/set occurs when the sun is at 108deg.


Get todays sunrise/sunset data:

Make a call to /sunrise/today/:lat/:lng/:tz1/:tz2 where you provide the latitude, longitude, and timezone.

This will return a hash where the key is today's date in YYYY-MM-DD format and the value is a hash of all rise/set data. Ex:

	{
	    "2010-08-11": {
	        "civil_sunrise": "05:41:00 -0700",
	        "official_sunset": "20:05:00 -0700",
	        "official_sunrise": "06:10:00 -0700",
	        "nautical_sunrise": "05:05:00 -0700",
	        "civil_sunset": "20:34:00 -0700",
	        "astronomical_sunset": "21:48:00 -0700",
	        "nautical_sunset": "21:10:00 -0700",
	        "astronomical_sunrise": "04:27:00 -0700"
	    }
	}


More Examples
-------------

Performance
-----------

Author
------

License
-------
