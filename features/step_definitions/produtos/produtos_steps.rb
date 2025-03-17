Dado('que esteja logado') do
  @product.inject_header('authorization', @authorization)
end

Dado('que tenhas os parametros {string}, {string}, {string}, {string} preenchidos com dados validos') do |nome, preco, descricao, quantidade|
  @params = {
    nome.to_sym => 'Produto A',
    preco.to_sym => 999,
    descricao.to_sym => 'Descrição do produto A',
    quantidade.to_sym => 10
  }
  # p @params
end

Dado('tenha um produto cadastrado') do
  step('que esteja logado')
  step('que tenhas os parametros "nome", "preco", "descricao", "quantidade" preenchidos com dados validos')
  step('realizar a requisição "post" para "/produtos" na rota de produtos')
end

Dado('tenha um id que não existe') do
  step('que esteja logado')
  @buffer_id = '5f5f5f5f5f'
end

Quando('alterar dados do produto') do
  @params = {
    nome.to_sym => 'Produto A Alterado',
    preco.to_sym => rand(1..1000),
    descricao.to_sym => 'Descrição do produto A Alterado',
    quantidade.to_sym => rand(1..1000)
  }
end

Quando('realizar a requisição {string} para {string} na rota de produtos') do |method, endpoint|
  case method
  when 'post'
    @res = @product.send("#{method}_create_product", endpoint, @params)
    @buffer_id = @res.parsed_response['_id'] if @res.code == 201
    p @buffer_id
  when 'get'
  when 'put'
    endpoint_id = endpoint.gsub('{id}', @buffer_id)
    @res = @product.send("#{method}_update_product", endpoint_id, @params)
    # p @res.parsed_response
    # p @res.code
  when 'delete'
    endpoint_id = endpoint.gsub('{id}', @buffer_id)
    @res = @product.send("#{method}_product", endpoint_id)
    p endpoint_id
    p @res
  else
    raise 'invalid method => ' + method
  end
end

Entao('deve retornar o schema de produtos em {string} e o status code {string}') do |schema, status|
  schema = Utils.get_schema schema, status
  aggregate_failures 'Validating status code and schemas' do
    expect(@res.code).to eq status.to_i
    expect(JSON::Validator.validate!(schema, @res.parsed_response)).to be true
  end  
  clear_variables
end