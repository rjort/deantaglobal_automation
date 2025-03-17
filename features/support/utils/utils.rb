class Utils

  def self.get_schema(schema, status_code)
    p "Schema: #{schema}"
    p "Status Code: #{status_code}"
    JSON.parse(File.read("features/support/utils/schemas/#{schema}/#{status_code}.json"))
  end
end