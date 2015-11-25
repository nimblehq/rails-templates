require 'zeus/parallel_tests'

class CustomPlan < Zeus::ParallelTests::Rails
  def test(*args)
    # can be anything matching Guard::RSpec :results_file option in the Guardfile
    ENV['GUARD_RSPEC_RESULTS_FILE'] = 'tmp/guard_rspec_results.txt'
    super
  end
end

Zeus.plan = CustomPlan.new