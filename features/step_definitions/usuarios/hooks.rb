Before do
  @user = V1::Usuarios.new
  @params = {}
  @res = {}
  @buffer_id = nil
  @buffer_data = {}
end

def hook_messages(msg)
  p "Hook: #{msg}"
end

def clear_variables
  @params = {}
  @res = {}
  @buffer_data = {}
end

After('@DELETE_USER') do
  hook_messages('Delete user')
  res = @user.send('post_delete_user', "/usuarios/#{@buffer_id}")
  if res.code == 200
    p 'User deleted'
  else
    p 'User not deleted'
  end
end

Before('@CREATE_USER') do
  hook_messages('Create user')
  params = {
    nome.to_sym => "Reuter Regis Sobrinho",
    email.to_sym => "reuter_junior@hotmail.com",
    password.to_sym =>  "123456",
    administrador.to_sym => "false"
  }

  res = @user.send('post_create_user', '/usuarios', params)

  if res.code == 201
    p 'User created'
    p res.parsed_response['_id']
    p res.parsed_response['email']
    p res.parsed_response['nome']
    p res.parsed_response['administrador']
    p res.parsed_response['password']
    @buffer_data['id'] = res.parsed_response['_id']
    @buffer_data['email'] = res.parsed_response['email']
    @buffer_data['nome'] = res.parsed_response['nome']
    @buffer_data['administrador'] = res.parsed_response['administrador']
    @buffer_data['password'] = res.parsed_response['password']
  else
    p 'User not created'
  end
end
