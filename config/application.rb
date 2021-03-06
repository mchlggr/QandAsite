require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module QA
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    # デフォルトのlocaleを日本語(:ja)にする
    config.i18n.default_locale = :ja
    # i18nの複数ロケールファイルが読み込まれるようpathを通す
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.{rb,yml}').to_s]

    # RSpec
    config.generators do |g|
      g.test_framework :rspec, 
            view_specs: false, 
            helper_specs: false, 
            controller_specs: false, 
            routing_specs: false
    end
  end
end
