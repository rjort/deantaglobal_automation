class V1
  class Login
    include HTTParty

    base_uri $base_url

    def initialize
      @headers = {
        'Content-Type' => 'application/json'
      }
    end

    def log_in(endpoint, body)
      self.class.post(endpoint, headers: @headers, body: body.to_json)
    end
  end
end