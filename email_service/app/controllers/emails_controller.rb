class EmailsController < ApplicationController

	def sendmail
		p params
		 render json: {}, status: :ok
	end
end
