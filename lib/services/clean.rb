module Services
	class Clean
		def delete_unassigned(pilots, parser)
			time = Time.at(DateTime.now())
			squawks = Squawk.all
			online_squawks = []
			to_delete = []

			pilots.each do |pilot|
				online_squawks << parser.get_squawk(pilot)
			end

			squawks.each do |sq|
				if !sq.paired
					((time - Time.at(sq.created_at)) / 1.minute).round
					if ((time - Time.at(sq.created_at)) / 1.minute).round > 30
						sq.delete
						logger = Rails.logger
						logger.info "mazu sq: #{sq.code} s id #{sq.id} "
					end
				end

				if  sq.paired && (!online_squawks.include? sq.code)
					to_delete << sq
				end

				if !sq.flight_id && sq.paired
					to_delete << sq
				end
			end

			to_delete.each do |sq|
				sq.delete
				logger = Rails.logger
				logger.info "mazu sq bez letu co byl paired #{sq.code}"
			end
		end

		def delete_non_relevant
			squawks = Squawk.all
			squawks.each do |sq|
				if sq.code == "MANUAL" || sq.code == "FULL"
					sq.delete
				end
			end
		end

		def delete_not_found(json)
			pilots = Flight.all
			pilots.each do |pilot|
				if !json.find {|i| i["callsign"].strip == pilot.callsign.strip}
					puts "Mazu zaznam #{pilot.callsign}"
					pilot.destroy!
				end
			end
		end
	end
end
