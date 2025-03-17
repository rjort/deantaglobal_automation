class V1
  class Usuarios
    include HTTParty

    base_uri $base_url

    def initialize
      p ENVIRONMENT
      @headers = { 'Content-Type' => 'application/json' }
    end

    protected def inject_header(key, value)
      @headers[key] = value
    end

    def post_create_user(endpoint, body)
      self.class.post(endpoint, headers: @headers, body: body.to_json)
    end

    def get_all_users(endpoint)
      self.class.get(endpoint, headers: @headers)
    end

    def get_user_by_id(endpoint_id)
      self.class.get(endpoint_id, headers: @headers)
    end

    def post_delete_user(endpoint)
      self.class.delete(endpoint, headers: @headers)
    end
  end
end