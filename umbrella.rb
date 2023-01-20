p "====================================="
p "Will you need an umbrella today?"
p "====================================="
p "Where are you located?"

user_location = gets.chomp

p "Checking the weather at #{user_location}..."

# google maps url 
# what can i modify about the url to get different info
gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{ENV.fetch("GMAPS_KEY")}"

# goes and gets the page at the url and returns it as an object
require("open-uri")
raw_data = URI.open(gmaps_url).read

require "json"
parsed_data =  JSON.parse(raw_data)

results_array = parsed_data.fetch("results")

only_results = results_array[0] 

geometry = only_results.fetch("geometry")

location = geometry.fetch("location")

lat = location.fetch("lat")
long = location.fetch("lng")

p "Your coordinates are #{lat}, #{long}."


# there's a method called .dig that is probably faster

# print driven development to make sure that each step it's accomplishing what you think

dark_sky_url = "https://api.darksky.net/forecast/#{ENV.fetch("DARK_SKY_KEY")}/#{lat},#{long}"

#p dark_sky_url

raw_dark_sky_data = URI.open(dark_sky_url).read
parsed_dark_sky_data =  JSON.parse(raw_dark_sky_data)

#p parsed_dark_sky_data

# Display the current temperature and summary of the weather for the next hour.

dark_sky_results = parsed_dark_sky_data

#p dark_sky_results

dark_sky_results_currently = dark_sky_results.fetch("currently")

curr_temp = dark_sky_results_currently.fetch("temperature")
curr_temp_str = "it is currently #{curr_temp} degrees"

p curr_temp_str

dark_sky_results_hourly = dark_sky_results.fetch("hourly")

hourly_summary = dark_sky_results_currently.fetch("summary")
hourly_str = "Next hour: #{hourly_summary}"

p hourly_str

hourly_data = dark_sky_results_hourly.fetch("data")

# next 12 hours not including the current hour
next_12_hours = hourly_data[1, 13]

#p hourly_data[0]

count = 1
rain_likely = false
next_12_hours.each do |one_hour|
  precipitation = one_hour.fetch("precipProbability")
  if precipitation > 0.1
   p "There is a #{precipitation} probability of rain #{count} hours from now!"
   rain_likely = true
  end
  count += 1
end

if rain_likely
  p "You might want to carry an umbrella!"
else
  p "You probably won't need an umbrella today"
end
