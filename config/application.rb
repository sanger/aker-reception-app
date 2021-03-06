require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)


def config_all_envs_for(name)
  yaml = Pathname.new("#{paths["config"].existent.first}/#{name}.yml")

  if yaml.exist?
    require "erb"
    (YAML.load(ERB.new(yaml.read).result) || {}) || {}
  else
    raise "Could not load configuration. No such file - #{yaml}"
  end
rescue Psych::SyntaxError => e
  raise "YAML syntax error occurred while parsing #{yaml}. "          "Please note that YAML must be consistently indented using spaces. Tabs are not allowed. "          "Error: #{e.message}"
end

module Submission
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Settings in config/environments/* take precedence over those specified here.
    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: true,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: false,
                       request_specs: true

      g.fixture_replacement :factory_bot, dir: 'spec/factories'

      g.assets false
    end

    config.ldap = config_for(:ldap)
    config.manifest_schema_config = config_all_envs_for(:manifest_schema)

    config.eager_load_paths << Rails.root.join('lib')
  end
end
