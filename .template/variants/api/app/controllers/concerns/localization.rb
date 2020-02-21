module Localization
  extend ActiveSupport::Concern

  included do
    before_action :set_locale

    protected

    def set_locale
      I18n.locale = request.headers[:'Accept-Language'] || I18n.default_locale
    end
  end
end
