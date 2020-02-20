require 'minitest/autorun'
require 'minitest/around/spec'

class Minitest::Spec
  around do |test|
    Dir.chdir("../#{ENV.fetch('APP_NAME')}") { test.call }
  end
end
