class Squawk < ApplicationRecord
	has_many :flights, inverse_of: :squawk

	def determine_bank(bank_request)
		bank = Bank.find_by name: bank_request
		return bank
	end

	def has_free(squawk_code)
		if Squawk.find_by code: squawk_code
			return false
		else
			return true
		end
	end

	def provide_squawk(bank, provided_code)

		if has_free(provided_code)
			return provided_code

		elsif has_free(provided_code) == false

			new_code = "#{provided_code.to_i + 1}"

			if bank.name == "LKTB" && new_code.to_i > 4327
				bank = determine_bank("LKTB_EXT")
				new_code = "3326"
			end

			if((provided_code.to_i % 10) >= 7) && bank.name != "LKTB"
				int_code = provided_code.to_i
				new_code_int = int_code + (10 - (int_code % 10))
				new_code = "#{new_code_int}"
			end

			if provided_code == bank.max
				return "FULL"
			end
			provide_squawk(bank, new_code)

		else
			return "MANUAL"
		end
	end
end