require 'test_helper'
require "minitest/autorun"

class MailgunServiceTest < Minitest::Test

	def setup
		to_address = "fake@example"
		to_name = "Mr. Fake"
		from_address= "noreply@mybrightwheel.com"
		from_name= "Brightwheel"
		subject= "A Message from Brightwheel"
		body= "<h1>Your Bill</h1><p>$10</p>"
		params = {to: to_address, to_name: to_name, from: from_address,
			from_name: from_name, subject: subject, body: body}
		@email = Email.new(params)
		@data = {"from": "#{from_address}",
		 "to": "#{to_address}",
		  "subject": "#{subject}",
		  "text": @email.body }
		@key = "key-12345"
		@domain = "sandboxc66addaf2caf43bba3aaff7a5f3f7ab0.mailgun.org"
		@config = {"apiKey" => @key, "url" => "https://api:<key>@api.mailgun.net/v3/<domain>/messages", 
		"domain" => @domain}
	end
	
	def test_should_send_mail
		response = ""
		uri = URI.parse("https://api:#{@key}@api.mailgun.net/v3/#{@domain}/messages")
		success_response = Net::HTTPResponse.new(2,"200","success")
	    Net::HTTP.stub(:post_form, success_response, [uri, @data]) do
		  ms = MailgunService.new(@config)
	      response = ms.sendmail(@email)
	    end
		assert_equal true, response
	end

	def test_sendmail_fails
		response = ""
	 	raises_exception = -> { raise ArgumentError.new }
	    Net::HTTP.stub(:post_form, raises_exception) do
		  ms = MailgunService.new(@config)
	      response = ms.sendmail(@email)
	    end
	    assert_equal false, response
	end

end