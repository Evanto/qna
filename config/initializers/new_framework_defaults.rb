# Be sure to restart your server when you modify this file.
#
# This file contains migration options to ease your Rails 5.0 upgrade.
#
# Read the Guide for Upgrading Ruby on Rails for more info on each option.

Rails.application.config.raise_on_unfiltered_parameters = true

# Enable per-form CSRF tokens. Previous versions had false.
Rails.application.config.action_controller.per_form_csrf_tokens = true

# Enable origin-checking CSRF mitigation. Previous versions had false.
Rails.application.config.action_controller.forgery_protection_origin_check = true

# Make Ruby 2.4 preserve the timezone of the receiver when calling `to_time`.
# Previous versions had false.
ActiveSupport.to_time_preserves_timezone = true

# Require `belongs_to` associations by default. Previous versions had false.
Rails.application.config.active_record.belongs_to_required_by_default = true

# Do not halt callback chains when a callback returns false. Previous versions had true.
# ActiveSupport.halt_callback_chains_on_return_false = false # I commented out this line to avoid
#'DEPRECATION WARNING: ActiveSupport.halt_callback_chains_on_return_false= is deprecated and will
# be removed in Rails 5.2. (called from <top (required)> at /home/ubuntu/www/qna/config/initializ
# ers/new_framework_defaults.rb:23), more on it here:
# http://blog.bigbinary.com/2016/02/13/rails-5-does-not-halt-callback-chain-when-false-is-returned.html

# Configure SSL options to enable HSTS with subdomains. Previous versions had false.
Rails.application.config.ssl_options = { hsts: { subdomains: true } }
