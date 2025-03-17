Dado('that I am logged in') do
  @product.inject_header('authorization', @authorization)
end

Dado('that the parameters {string}, {string}, {string}, {string} are filled with valid data') do |nome, preco, descricao, quantidade|
  @params = {
    nome.to_sym => 'Produto A',
    preco.to_sym => 999,
    descricao.to_sym => 'Descrição do produto A',
    quantidade.to_sym => 10
  }
  # p @params
end

Dado('there is a registered product') do
  step('that I am logged in')
  step('that the parameters "nome", "preco", "descricao", "quantidade" are filled with valid data')
  step('making a "post" request to "/produtos" on the products route')
end

Dado('that there is an id that does not exist') do
  step('that I am logged in')
  @buffer_id = '5f5f5f5f5f'
end

Quando('updating product data') do
  @params = {
    nome.to_sym => 'Produto A Alterado',
    preco.to_sym => rand(1..1000),
    descricao.to_sym => 'Descrição do produto A Alterado',
    quantidade.to_sym => rand(1..1000)
  }
end

Quando('making a {string} request to {string} on the products route') do |method, endpoint|
  case method
  when 'post'
    @res = @product.send("#{method}_create_product", endpoint, @params)
    @buffer_id = @res.parsed_response['_id'] if @res.code == 201
    p @buffer_id
  when 'get'
  when 'put'
    endpoint_id = endpoint.gsub('{id}', @buffer_id)
    @res = @product.send("#{method}_update_product", endpoint_id, @params)
    p @res.parsed_response
    p @res.code
  when 'delete'
    endpoint_id = endpoint.gsub('{id}', @buffer_id)
    @res = @product.send("#{method}_product", endpoint_id)
    p endpoint_id
    p @res
  else
    raise 'invalid method => ' + method
  end
end

Entao('it should return the products schema in {string} and the status code {string}') do |schema, status|
  schema = Utils.get_schema schema, status
  aggregate_failures 'Validating status code and schemas' do
    expect(@res.code).to eq status.to_i
    expect(JSON::Validator.validate!(schema, @res.parsed_response)).to be true
  end  
  clear_variables
end
