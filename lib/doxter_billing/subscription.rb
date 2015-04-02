require 'faraday'
require 'json'

module DoxterBilling
  class Subscription
    attr_accessor :id, :account_id, :article_code, :pricing, :leads, :status, :event

    API_URL = "http://billing.doxter.de/api/v1/subscriptions.json"
    #API_URL = "http://localhost:3000/api/v1/subscriptions.json"

    def initialize(attributes)
      @id = attributes['abo_id']
      @account_id = attributes['datev']
      @article_code = attributes['article_code']
      @pricing = attributes['pricing']
      @leads = attributes['leads']
      @status = attributes['status']
      @event = attributes['event']
    end

    def self.all
      convert_to_subscription(request)
    end

    def self.get(abo_id)
      response = request('get' => "#{abo_id}")
      convert_to_subscription(response)
    end

    def self.since(sync_token)
      response = request('sync_token' => "#{sync_token}")
      convert_to_subscription(response)
    end

    def self.request(parameter = nil)
      conn = Faraday.new
      conn.basic_auth(ENV['DOXTER_BILLING_API_USER'], ENV['DOXTER_BILLING_API_PASSWORD'])
      conn.params = parameter if parameter.is_a? Hash
      conn.get "#{API_URL}"
    end

    def self.next_sync_token
      @next_sync_token
    end

    def self.convert_to_subscription(web_response)
      api_response = JSON.parse(web_response.body)
      @next_sync_token = api_response['nextSyncToken']
      subscriptions = api_response['data']
      subscriptions.map { |attributes| new(attributes) }
    end
  end
end
