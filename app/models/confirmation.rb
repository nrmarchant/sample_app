class Confirmation < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
	state_machine initial: :unconfirmed do
		state :unconfirmed, value: 0
		state :confirmed, value: 1

		event :confirm do
			transition :unconfirmed => :confirmed
		end

		event :update_email do
			transition :confirmed => :unconfirmed
		end
	end
end
