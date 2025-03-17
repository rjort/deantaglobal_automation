Dado('tenha os parametros {string}, {string}, {string} preenchidos com dados validos') do |nome, email, password|
  @params = {
    nome.to_sym => "Reuter Regis Sobrinho",
    email.to_sym => "reuter_junior@hotmail.com",
    password.to_sym =>  "123456"
  }
end

Dado('tenha um usuario cadastrado') do
  step('tenha os parametros "nome", "email", "password" preenchidos com dados validos')
  step('tenha o parametro "administrador" setado como "false"')
  step('realizar a requisição "post" para "/usuarios"')
end

Dado('realize novamente o mesmo cadastro para o mesmo usuario') do
  step('tenha os parametros "nome", "email", "password" preenchidos com dados validos')
  step('tenha o parametro "administrador" setado como "false"')
end

Dado('tenha o parametro {string} setado como {string}') do |admin, value|
  case value
  when 'true'
    @params[admin.to_sym] = value
  when 'false'
    @params[admin.to_sym] = value
  else
    raise 'Invalid value'
  end
end

Dado('busque por um id de usuario cadastrado') do
  @id = @response.parsed_response['_id']
end

Quando('realizar a requisição {string} para {string}') do |method, endpoint|
  case method
  when 'post'
    @response = @user.send("#{method}_create_user", endpoint, @params)
    @buffer_id = @response.parsed_response['_id'] if @response.code == 201
    p @buffer_id
  when 'get'
    @response = @user.send("#{method}_all_users", endpoint)  
  else
    raise 'invalid method => ' + method
  end
  p @response
end

Quando("realizar a requisição {string} para buscar um usuario por id na rota {string}") do |method, endpoint|
  step('busque por um id de usuario cadastrado')
  endpoint_id = endpoint.gsub('{id}', @id)
  p endpoint_id
  @response = @user.send("#{method}_user_by_id", endpoint_id)
end

Então('deve retornar o schema {string} e o status code {string}') do |schema, status|
  schema = Utils.get_schema schema, status
  aggregate_failures 'Validating status code and schemas' do
    expect(@response.code).to eq status.to_i
    expect(JSON::Validator.validate!(schema, @response.parsed_response)).to be true
  end  
  clear_variables
end