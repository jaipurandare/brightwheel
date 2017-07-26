require 'uri'
require 'net/http'
require 'json'

class SendgridService

	def initialize(config)
		@apiKey = config["apiKey"]
		@url = config["url"]
	end

	def sendmail(email)
		data = construct_data(email).to_json
		begin
			uri = URI.parse(@url)
			req = Net::HTTP::Post.new(uri.path)
			req.body = data
			req["Content-Type"] = "application/json"
			req["Authorization"] = "Bearer #{@apiKey}"
			is_success = true
			http = Net::HTTP.new(uri.host, uri.port)
			http.use_ssl = true
			resp = http.start{|http| http.request(req) }
			is_success = is_valid_response(resp)
		rescue Exception => e
			p e.message, e
			resp = false
		end
  		return is_success
	end

	private

	def construct_data(email)
		return {
			  "personalizations": [
			    {
			      "to": [
			        {
			          "email": "#{email.to}"
			        }
			      ],
			      "subject": "#{email.subject}"
			    }
			  ],
			  "from": {
			    "email": "#{email.from}"
			  },
			  "content": [
			    {
			      "type": "text/plain",
			      "value": "#{email.text}"
			    }
			  ]
			}
	end

	def is_valid_response(res)
		success = res.code=="202"
		p res.code, res if !success
		return success
	end
end