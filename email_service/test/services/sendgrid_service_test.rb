require 'test_helper'
require "minitest/autorun"


class SendgridServiceTest < Minitest::Test

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
		@data = {"from": "#{from_name}<#{from_address}>",
		 "to": "#{to_address}",
		  "subject": "#{subject}",
		  "text": "#{to_name}#{body}" }
		@key = "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"
		@config = {"apiKey" => @key, "url" => "https://api.sendgrid.com/v3/mail/send", 
		"domain" => @domain}
	end
	
	def test_should_send_mail
		uri = URI.parse(@config["url"])
		ss = SendgridService.new(@config)
		response = ""
		success_response = Net::HTTPResponse.new(2,"202","accepted")
		mock = MiniTest::Mock.new
		mock.expect(:start, success_response)
		mock.expect(:use_ssl=, nil, [true])
	    Net::HTTP.stub(:new, mock, [uri.host, uri.port]) do
	      response = ss.sendmail(@email)
	    end
	    mock.verify
		assert_equal true, response
	end

	# def test_sendmail_fails
	# 	uri = URI.parse(@config["url"])
	# 	ss = SendgridService.new(@config)
	# 	response = ""
	#  	raises_exception = -> { raise Exception.new }
	#     Net::HTTP.stub(:new, raises_exception) do
	#       response = ss.sendmail(@email)
	#     end
	#     assert_equal false, response
	# end
	
	def test_sendmail_sengrid_returns_failure
		ss = SendgridService.new(@config)
		response = ""
	 	raises_exception = -> { raise Exception.new }
	    Net::HTTP.stub(:start, raises_exception) do
	      response = ss.sendmail(@email)
	    end
	    assert_equal false, response
	end

end