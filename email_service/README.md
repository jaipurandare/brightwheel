# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


Why Ruby on Rails?
1. Ruby is an Object Oriented Language.
2. It comes with unit testing support and promotes TDD. Reduces external dependencies making development easy and faster.
3. It has good dependency management through bundler. Developers productivity is not hampered because of dependency management.
4. Rake support helps in automating tasks for ease of development.
5. Overall ease of coding.


How to run code and tests?
	Dependecies
	1. Ruby and Rails needs to be installed on the system. This code is built with Ruby 2.3.3 and Rails 5.1.
	2. Rubygem Sanitize is used.

	Running the code.
	1. Run command bundle install.
	2. Start server with rails server
	3. For send request, use postman app.
	4. To change the primary/default mailing service, give the appropriate name(mailgun or sendgrid) for the 'primary' field in email_service.yml under config directory. 

	Running the tests
	From the terminal run the 'rake test' task to run all tests
	Example
	$ rake test

TradeOffs
1. Factory to inject MailingService is not created. Currently its instantiated in the controller
2. There is not Authentication/Authorization for the service
3. Timeout for external services is not handled.
4. Api keys are saved in the email_service.yml file. Those should be environment variables.
5. Custom domains are not added and verified for the current 3rd party accounts. So sending emails may not work. Mailgun has been successsfully configured to send mails to jai2005@gmail.
6. The code is tested only in the development environment. 
7. Response of the api is basic. Response code + messaging needs to be improved.