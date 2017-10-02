require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Qna
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # сконфигурим генераторы.
    # укажем, что тестовый фреймворк - rspec. по умолчанию, когда мы
    # ставим rspec, он уже сконфигурирован, но поскольку мы сейчас меняем его параметры,
    # нам приходится указывать снова вручную. Дальше идет список того, что нам нужно и не нужно:
    #config.web_console.whitelisted_ips = '10.0.2.2'
    config.action_cable.disable_request_forgery_protection = false

    config.generators do |g|
      g.test_framework :rspec,
                        fixtures: true, # фикстуры
                        view_spec: false, # спеки для вьюх
                        helper_specs: false, # спеки для хелперов
                        routing_specs: false, # спеки для роутов
                        request_specs: false, # спеки для реквестов
                        controller_specs: true
   # укажем, что фикстуры должны создаваться с помощью factory_girl и путь, где они будут храниться:
     g.fixture_replacement :factory_girl, dir: 'spec/factories/'
   end
  end
end
