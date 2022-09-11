require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module BatchSample
  class Application < Rails::Application
    config.load_defaults 6.0

    config.time_zone = 'Tokyo'
    # :utcと:localから選択できる。:localにするとOSのタイムゾーンと同じ設定を参照する
    config.active_record.default_timezone = :local
  end
end
