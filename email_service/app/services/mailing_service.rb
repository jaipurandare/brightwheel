class MailingService

	def initialize(config)
		mailgun = MailgunService.new(config["mailgun"])
		sendgrid = SendgridService.new(config["sendgrid"])
		services = {"mailgun" => mailgun, "sendgrid" => sendgrid}
		@primary = services[config["primary"]]
		@secondary = services.select{|k, v| k != config["primary"]}.values[0]
	end


	def sendmail(email)
		response = @primary.sendmail(email)
		if !response
			response = @secondary.sendmail(email) 
		end
		return response
	end

end