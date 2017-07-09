require 'test_helper'

class EmailsControllerTest < ActionDispatch::IntegrationTest

	def test_dispatch_email
		post "/email", params: {"to": "fake@example.com",
			"to_name": "Mr. Fake",
			"from": "noreply@mybrightwheel.com",
			"from_name": "Brightwheel",
			"subject": "A Message from Brightwheel",
			"body": "<h1>Your Bill</h1><p>$10</p>"}
		assert_equal 200, status
	end
end
