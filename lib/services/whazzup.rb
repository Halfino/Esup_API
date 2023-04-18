module Services
	class Whazzup

		def get_pilots(json)
			return json["clients"]["pilots"]
		end

		def get_departure(pilot)
			return pilot["flightPlan"]["departureId"]
		end

		def get_arrival(pilot)
			return pilot["flightPlan"]["arrivalId"]
		end

		def get_callsign(pilot)
			return pilot["callsign"]
		end

		def get_onGround(pilot)
			last_track = pilot["lastTrack"]
			if last_track
				return last_track["onGround"]
			else
				return true
			end
		end

		def get_state (pilot)
			last_track = pilot["lastTrack"]
			if last_track
				return last_track["state"]
			else
				return "No Track"
			end
		end

		def get_squawk (pilot)
			last_track = pilot["lastTrack"]
			if last_track
				squawk = "#{last_track["transponder"]}"
				case squawk.length
					when 1
						return "000#{squawk}"
					when 2
						return "00#{squawk}"
					when 3
						return "0#{squawk}"
					else
						return squawk
				end
			end
		end
	end
end
