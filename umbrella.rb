p "Where are you located?"

#user_location = gets.chomp

user_location = "Chicago"

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

# there's a method called .dig that is probably faster

p lat 
p long

# print driven development to make sure that each step it's accomplishing what you think
