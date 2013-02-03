require 'aws'
AWS.config(:logger => Rails.logger)
AWS.config(Setting.aws)
