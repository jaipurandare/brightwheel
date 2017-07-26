require 'sanitize'

class Email
	include ActiveModel::Validations

	attr_reader :to, :to_name, :from, :from_name, :subject, :body

	validates :to, presence: true, email_address: true
	validates :to_name, presence: true
	validates :from, presence: true
	validates :from_name, presence: true
	validates :subject, presence: true
	validates :body, presence: true

	def initialize(params)
		populate(params["to"], params["to_name"], params["from"], params["from_name"], params["subject"],params["body"])
	end

	def text
		cleaned_body = Sanitize.fragment(@body)
		formated_text = "Hi #{@to_name}\n#{cleaned_body}\nThank you,\n#{@from_name}"
		return formated_text
	end

	private
	def populate(to, to_name, from, from_name, subject, body)
		@to = to
		@to_name = to_name
		@from = from
		@from_name = from_name
		@subject = subject
		@body = body
	end
end
