# Controllers
directory 'app/controllers/concerns'
inject_into_class 'app/controllers/application_controller.rb', 'ApplicationController' do
  <<~RUBY.indent(2)
    include Localization
  RUBY
end
