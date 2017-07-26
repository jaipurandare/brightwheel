require 'test_helper'
require "minitest/autorun"

class EmailsControllerTest < ActionDispatch::IntegrationTest

	def test_sendemail
		params = {"to"=> "fake@example.com",
			"to_name"=> "Mr. Fake",
			"from"=> "noreply@mybrightwheel.com",
			"from_name"=> "Brightwheel",
			"subject"=> "A Message from Brightwheel",
			"body"=> "<h1>Your Bill</h1><p>$10</p>"}
		email = Email.new(params)
		res = ""
		mock = MiniTest::Mock.new
	    mock.expect(:sendmail, true, [email])
		MailingService.stub(:new, mock) do
			res = post "/email",params: params, as: :json
	    end
	    mock.verify
		
		assert_equal 200, status
	end
end
