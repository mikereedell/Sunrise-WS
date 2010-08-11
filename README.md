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

All methods take a common set of parameters:

- Latitude: Decimal representation of the locations latitude (+ when above the equator, - below).
- Longitude: Decimal representation of the locations longitude (+ when east of the Prime Meridian, - when west).
- Timezone will be in two parts, the first being the country/region and the second being the city, ie, "America/New_York".  See [http://tzinfo.rubyforge.org/svn/trunk/tzinfo/lib/tzinfo/indexes/timezones.rb](http://tzinfo.rubyforge.org/svn/trunk/tzinfo/lib/tzinfo/indexes/timezones.rb) for all available timezone identifiers in the tzinfo gem.


### Get todays sunrise/sunset data ###

Call /sunrise/today/:lat/:lng/:tz1/:tz2 with the latitude, longitude, and timezone data of the location.

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

### Get sunrise/sunset data for a specific date ###

Call /sunrise/:date/:lat/:lng/:tz1/:tz2  with the latitude, longitude, and timezone data of the location along with the date.  The given date must be in the format 'YYYY-MM-DD' or the response will be a 500 error.

This will return a hash where the key is the date that was passed in and the value is a hash of all rise/set data:

	{
    	"2008-11-01": {
	        "civil_sunrise": "07:05:00 -0700",
	        "official_sunset": "18:00:00 -0700",
	        "official_sunrise": "07:33:00 -0700",
	        "nautical_sunrise": "06:33:00 -0700",
	        "civil_sunset": "18:28:00 -0700",
	        "astronomical_sunset": "19:31:00 -0700",
	        "nautical_sunset": "19:00:00 -0700",
	        "astronomical_sunrise": "06:01:00 -0700"
	    }
	}

### Get sunrise/sunset data for this year ###

Call /sunrise/year/:lat/:lng/:tz1/:tz2 with the latitude, longitude, and timezone identifier of the location.  

The response will be an array of 365 (or 366 on leap years) objects with identical structure to the "today" service.  The array will be sorted by date and index 0 will be 01 January.

Author
------

Mike Reedell

mike@reedell.com  
[http://www.mikereedell.com](http://www.mikereedell.com)


License
-------

Unless otherwise specified, files in this project fall under the following license:

	Copyright 2008-2010 Mike Reedell

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at

	     http://www.apache.org/licenses/LICENSE-2.0

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

An exception is made for files in readable text which contain their own license information or files where an accompanying file exists, in the same directory, with a "-license" suffix added to the base name of the original file, and an extension of txt, html, or similar.
