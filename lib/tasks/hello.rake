require 'net/http'
require 'json'
require 'services/whazzup'

namespace :downloader do

	task :download_whazzup => :environment do

		uri = URI('https://api.ivao.aero/v2/tracker/whazzup')
		whazzup = Net::HTTP.get_response(uri)
		json = JSON.parse(whazzup.body)

		parser = Services::Whazzup.new
		cleaner = Services::Clean.new
		pilots = parser.get_pilots(json)
		unassigned = Squawk.where(paired: false)

		pilots.each do |pilot|
			flight = Flight.find_or_initialize_by(callsign: parser.get_callsign(pilot).strip)
			if !flight.departure
				flight.departure = parser.get_departure(pilot)
				flight.arrival = parser.get_arrival(pilot)
			end
			flight.onGround = parser.get_onGround(pilot)
			flight.state = parser.get_state(pilot)
			flight.save
			flight.reload

			if flight.squawk == "2000" || flight.squawk == "1200" || flight.squawk == "7000"
				squawk = flight.squawk
				squawk.code = parser.get_squawk(pilot)
				squawk.save
			end

			if !flight.squawk
				flight.squawk = Squawk.create!(code:parser.get_squawk(pilot), paired: true)
			elsif unassigned.find {|sq| sq.code == parser.get_squawk(pilot)}
				sql = (unassigned.find {|sq| sq.code == parser.get_squawk(pilot)})
				sql.paired = true
				flight.squawk = sql
				flight.save
				sql.save
			end
		end

		cleaner.delete_not_found(pilots)
		cleaner.delete_unassigned(pilots, parser)
		cleaner.delete_non_relevant
	end
end