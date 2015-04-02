require './test/minitest_helper'

class DoxterBillingTest < Minitest::Test
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
      assert result.is_a?(Array)
      assert result.first.is_a?(DoxterBilling::Subscription)
    end
  end

  def test_the_get_function
    VCR.use_cassette('get_one_subscription') do
      result = DoxterBilling::Subscription.get 14303

      # Make sure we got all the cars
      assert_equal 1, result.length

      # Make sure that the JSON was parsed
      assert result.is_a?(Array)
      assert result.first.is_a?(DoxterBilling::Subscription)
      assert result.first.id == 14303
    end
  end

  def test_it_gives_back_changed_subscriptions
    VCR.use_cassette('changed_subscriptions') do
      result = DoxterBilling::Subscription.since('1:MjAxNS0wMy0wOVQxNDo1MjoxNSswMTowMA==')

      # Make sure we got all the cars
      assert_equal 2, result.length

      # Make sure that the JSON was parsed
      assert result.is_a?(Array)

      subscription = result.first
      assert subscription.is_a?(DoxterBilling::Subscription)

      # Check that the fields are accessible by our model
      assert_equal 8415, subscription.id
      assert_equal 12_930, subscription.account_id
      assert_equal 'standard', subscription.article_code
      assert_equal 'doxter-gkv=6;doxter-pkv=30', subscription.pricing
      assert_equal false, subscription.leads
      assert_equal 'active', subscription.status
      assert_equal 'updated', subscription.event
    end
  end

  def test_sync_token
    VCR.use_cassette('changed_subscriptions') do
      result = DoxterBilling::Subscription.since('1:MjAxNS0wMy0wOVQxNDo1MjoxNSswMTowMA==')

      # Make sure we got all the cars
      assert_equal "1:MjAxNS0wMy0wOVQxNDo1ODoyNyswMTowMA==", DoxterBilling::Subscription.next_sync_token
    end
  end
end
