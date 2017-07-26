require 'test_helper'

class EmailTest < Minitest::Test

	def test_validation_fails_for_invalid_to
		params = {"to"=> "fake@example",
			"to_name"=> "Mr. Fake",
			"from"=> "noreply@mybrightwheel.com",
			"from_name"=> "Brightwheel",
			"subject"=> "A Message from Brightwheel",
			"body"=> "<h1>Your Bill</h1><p>$10</p>"}
		email = Email.new(params)

		assert_equal false, email.valid?
	end
	
	def test_validation_fails_for_to
		params = {"to"=> "",
			"to_name"=> "Mr. Fake",
			"from"=> "noreply@mybrightwheel.com",
			"from_name"=> "Brightwheel",
			"subject"=> "A Message from Brightwheel",
			"body"=> "<h1>Your Bill</h1><p>$10</p>"}
		email = Email.new(params)

		assert_equal false, email.valid?
	end
	def test_validation_fails_for_to_name
		params = {"to"=> "fake@example.com",
			"to_name"=> "",
			"from"=> "noreply@mybrightwheel.com",
			"from_name"=> "Brightwheel",
			"subject"=> "A Message from Brightwheel",
			"body"=> "<h1>Your Bill</h1><p>$10</p>"}
		email = Email.new(params)

		assert_equal false, email.valid?
	end

	def test_validation_fails_for_from
		params = {"to"=> "fake@example.com",
			"to_name"=> "Mr. Fake",
			"from"=> "",
			"from_name"=> "Brightwheel",
			"subject"=> "A Message from Brightwheel",
			"body"=> "<h1>Your Bill</h1><p>$10</p>"}
		email = Email.new(params)

		assert_equal false, email.valid?
	end

	def test_validation_fails_for_from_name
		params = {"to"=> "fake@example.com",
			"to_name"=> "Mr. Fake",
			"from"=> "noreply@mybrightwheel.com",
			"from_name"=> "",
			"subject"=> "A Message from Brightwheel",
			"body"=> "<h1>Your Bill</h1><p>$10</p>"}
		email = Email.new(params)

		assert_equal false, email.valid?
	end

	def test_validation_fails_for_subject
		params = {"to"=> "fake@example.com",
			"to_name"=> "Mr. Fake",
			"from"=> "noreply@mybrightwheel.com",
			"from_name"=> "Brightwheel",
			"subject"=> "",
			"body"=> "<h1>Your Bill</h1><p>$10</p>"}
		email = Email.new(params)

		assert_equal false, email.valid?
	end

	def test_validation_fails_for_body
		params = {"to"=> "fake@example.com",
			"to_name"=> "Mr. Fake",
			"from"=> "noreply@mybrightwheel.com",
			"from_name"=> "Brightwheel",
			"subject"=> "A Message from Brightwheel",
			"body"=> ""}
		email = Email.new(params)

		assert_equal false, email.valid?
	end

	def test_format_body
		params = {"to"=> "fake@example.com",
			"to_name"=> "Mr. Fake",
			"from"=> "noreply@mybrightwheel.com",
			"from_name"=> "Brightwheel",
			"subject"=> "A Message from Brightwheel",
			"body"=> "<h1>Your Bill</h1><p>$10</p>"}
		email = Email.new(params)
		formated_body = "Hi Mr. Fake\n Your Bill  $10 \nThank you,\nBrightwheel"
		assert_equal formated_body, email.text
	end

end
