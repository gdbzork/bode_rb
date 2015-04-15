$LOAD_PATH.unshift File.expand_path('../lib', __FILE__)
require 'minitest/autorun'

require 'bode'

class TestBode < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::Bode::VERSION
  end

end
