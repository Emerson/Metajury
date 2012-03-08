require "#{Dir.pwd}/lib/application_settings.rb"

if Rails.env == 'test'
  ApplicationSettings.config = YAML.load_file("config/application_settings.example.yml")[Rails.env]
else
  ApplicationSettings.config = YAML.load_file("config/application_settings.yml")[Rails.env]
end