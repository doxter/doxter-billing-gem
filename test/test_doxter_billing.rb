require 'minitest_helper'

class TestDoxterBilling < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DoxterBilling::VERSION
  end

  def test_exists
    assert DoxterBilling::Subscription
  end
end
