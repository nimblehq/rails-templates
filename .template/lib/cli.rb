# frozen_string_literal: true

require 'thor'

module Template
  class Cli < Thor
    desc 'install_addon? ADDON_NAME', 'Prompt install message and return true if user input yes'
    def install_addon?(addon)
      yes?(install_addon_prompt(addon))
    end

    desc 'post_default_addons_install', 'Print out all installed default addons'
    def post_default_addons_install(default_addons)
      addons = ''
      default_addons.each_value do |default_addon|
        addons += "* #{default_addon}\n  "
      end

      message = <<~MESSAGE
        These default addons were installed:
          #{addons}
      MESSAGE

      say(message, :blue)
    end

    desc 'print_error_message ERRORS', 'Print out all error messages'
    def print_error_message(errors)
      return if errors.empty?

      message = <<~MESSAGE
        #{'=' * 80}

        There are some errors when templating the application, Please fix them manually:

        #{errors}
        #{'=' * 80}
      MESSAGE

      say_error(message, :red)
    end

    private

    def install_addon_prompt(addon)
      "Would you like to add the #{addon} addon? [Yn]"
    end
  end
end
