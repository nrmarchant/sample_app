class ConfirmationsController < ApplicationController
	
	def new

	end

	def create

	end

	def edit
		user = User.find_by(id: params[:id])
		user.confirmation.confirm
		redirect_to(root_url)
		flash[:sucess] = "Email confirmed!"
	end
end