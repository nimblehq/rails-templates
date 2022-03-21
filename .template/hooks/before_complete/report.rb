# frozen_string_literal: true

def report
  after_bundle do
    say "\n🚀 The project has been successfully created 🚀\n", :green

    # Report errors
    unless @template_errors.empty?
      print_separator
      say "\n📍 There were some errors when templating the application, please fix them manually:\n"
      say_error "\n#{@template_errors}\n"
    end

    # Report instructions
    unless @template_instructions.empty?
      print_separator
      say "\n📝 Please follow the instructions below to complete the setup:\n"
      say "\n#{@template_instructions}\n"
    end

    say "\n"
  end
end

def print_separator(color = nil)
  say "\n#{'=' * 80}\n", color
end

report
