class EmailsController < ApplicationController

	def sendmail
		ep = email_params(params)

		status = 200
		begin
			ms = MailingService.new(MAILING_SERVICES_CONFIG_DATA)

			email = Email.new(ep)
			if email.valid?
			p "email", email,email.valid?
				success = ms.sendmail(email)
				status = 500 if !success
			else
				status = 400
				result["errors"] = email.errors
			end
		rescue Exception => e
			p e.inspect, e.message
			status = 500
		end
		result = service_message(status)

		render json: result, status: status
	end

	private

	def email_params(params)
		return JSON.parse(request.body.read)
		# params.require([:to, :to_name, :from, :from_name, :subject, :body])
	end

	def service_message(status)
		return {"message" => SERVICE_MESSAGES[status]}
	end
end
