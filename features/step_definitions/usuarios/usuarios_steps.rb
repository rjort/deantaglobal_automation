Given('the parameters {string}, {string}, {string} are filled with valid data') do |nome, email, password|
  @params = {
    nome.to_sym => "Reuter Regis Sobrinho",
    email.to_sym => "reuter_junior@hotmail.com",
    password.to_sym =>  "123456"
  }
end

Given('there is a registered user') do
  step('the parameters "nome", "email", "password" are filled with valid data')
  step('the parameter "administrador" is set to "false"')
  step('making a "post" request to "/usuarios"')
end

Given('the same registration is made for the same user again') do
  step('the parameters "nome", "email", "password" are filled with valid data')
  step('the parameter "administrador" is set to "false"')
end

Given('the parameter {string} is set to {string}') do |admin, value|
  case value
  when 'true'
    @params[admin.to_sym] = value
  when 'false'
    @params[admin.to_sym] = value
  else
    raise 'Invalid value'
  end
end

Given('fetch a registered user by id') do
  @id = @response.parsed_response['_id']
end

When('making a {string} request to {string}') do |method, endpoint|
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

When("making a {string} request to fetch a user by id on the route {string}") do |method, endpoint|
  step('fetch a registered user by id')

  endpoint_id = endpoint.gsub('{id}', @id)
  p endpoint_id
  @response = @user.send("#{method}_user_by_id", endpoint_id)
end

Then('it should return the schema {string} and the status code {string}') do |schema, status|
  schema = Utils.get_schema schema, status
  aggregate_failures 'Validating status code and schemas' do
    expect(@response.code).to eq status.to_i
    expect(JSON::Validator.validate!(schema, @response.parsed_response)).to be true
  end  
  clear_variables
end