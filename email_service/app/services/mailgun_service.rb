require 'net/http'
require 'uri'
require 'json'
# require 'restclient'

class MailgunService

	def initialize(config)
		@apiKey = config["apiKey"]
		@url = config["url"]
		@domain = config["domain"]
		@url["<key>"] = @apiKey # raises exception
		@url["<domain>"] = @domain
	end

	def sendmail(email)
  		uri = URI.parse(@url)
		data = construct_data(email)
		response = true
		begin
  			res = Net::HTTP.post_form(uri, data)
  			response = is_valid_response(res)
  			# record the id if required
  		rescue Exception => e
  			# log error
  			response = false
  		end
		return response
	end

	private

	def construct_data(email)
		return {"from": "#{email.from}",
		 "to": "#{email.to}",
		  "subject": "#{email.subject}",
		  "text": "#{email.text}"}
	end

	def is_valid_response(res)
		success = res.code=="200"
		p res.code, res if !success
		return success
	end
end