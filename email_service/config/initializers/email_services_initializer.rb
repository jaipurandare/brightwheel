# require 'mailing_service_config.rb'

MAILING_SERVICES_CONFIG_DATA = YAML.load_file(Rails.root.join('config','email_services.yml'))[Rails.env]

SERVICE_MESSAGES = {200 => "Email sent successfully",
				500 => "Internal server error",
				400 => "Bad request"}
