require './test/minitest_helper'

class TestDoxterBilling < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::DoxterBilling::VERSION
  end

  def test_exists
    assert DoxterBilling::Subscription
  end

  def test_it_gives_back_all_the_subscriptions
    VCR.use_cassette('all_subscriptions') do
      result = DoxterBilling::Subscription.all

      # Make sure we got all the cars
      assert_equal 709, result.length

      # Make sure that the JSON was parsed
      assert result.kind_of?(Array)
      assert result.first.kind_of?(DoxterBilling::Subscription)
    end
  end

  def test_it_gives_back_changed_subscriptions
    VCR.use_cassette('changed_subscriptions') do
      result = DoxterBilling::Subscription.since('1:MjAxNS0wMy0wOVQxNDo1MjoxNSswMTowMA==')

      # Make sure we got all the cars
      assert_equal 2, result.length

      # Make sure that the JSON was parsed
      assert result.kind_of?(Array)

      subscription = result.first
      assert subscription.kind_of?(DoxterBilling::Subscription)

      # Check that the fields are accessible by our model
      assert_equal 8415, subscription.id
      assert_equal 12930, subscription.account_id
      assert_equal "standard", subscription.article_code
      assert_equal "doxter-gkv=6;doxter-pkv=30", subscription.pricing
      assert_equal false, subscription.leads
      assert_equal "active", subscription.status
      assert_equal "updated", subscription.event
    end
  end
end
