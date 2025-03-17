class V1
  class Produtos
    include HTTParty

    base_uri $base_url

    def initialize
      p 'Prodcts Service'
      @headers = { 'Content-Type' => 'application/json' }
    end

    def inject_header(key, value)
      @headers[key] = value
      # p @headers
    end

    def post_create_product(endpoint, body)
      p body
      p endpoint
      res = self.class.post(endpoint, headers: @headers, body: body.to_json)
      p "Response POST: #{res}"
      res
    end

    def put_update_product(endpoint_id, body)
      self.class.put(endpoint_id, headers: @headers, body: body.to_json)
    end

    def delete_product(endpoint_id)
      self.class.delete(endpoint_id, headers: @headers)
    end
  end
end