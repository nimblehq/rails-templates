module Localization
  extend ActiveSupport::Concern

  included do
    around_action :switch_locale

    protected

    def switch_locale(&action)
      locale = extract_locale_from_header || I18n.default_locale

      I18n.with_locale(locale, &action)
    end

    def extract_locale_from_header
      return request.headers[:'Accept-Language'] if I18n.locale_available?(request.headers[:'Accept-Language'])
      
      nil
    end

    private

    def default_url_options
      { locale: I18n.locale == I18n.default_locale ? nil : I18n.locale }
    end
  end
end
