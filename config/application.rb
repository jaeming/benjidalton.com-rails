require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rails4Example
  class Application < Rails::Application

    config.middleware.insert_before 0, "Rack::Cors" do
        allow do
          origins '*'
          resource '*', :headers => :any, :methods => [:get]
        end
      end

    config.autoload_paths += %W(#{config.root}/app/services)
    config.eager_load_paths += %W(#{config.root}/app/services)
  end
end
