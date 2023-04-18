class Flight < ApplicationRecord
	has_one :squawk, dependent: :destroy, inverse_of: :flights
end
