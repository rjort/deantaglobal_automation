require_relative '../../services/login.rb'

Before do
  @product = V1::Produtos.new
  @params = {}
  @res = {}
  @buffer_id = nil
  @buffer_data = {}
  @authotization = nil
end

def hook_messages(msg)
  p "Hook: #{msg}"
end

def clear_variables
  @params = {}
  @res = {}
  @buffer_data = {}
end

# {
# "nome": "Fulano da Silva",
# "email": "fulano@qa.com",
# "password": "teste",
# "administrador": "true",
# "_id": "0uxuPY0cbmQhpEz1"
# }
Before('@Login') do
  hook_messages('Login')
  params = {
    "email".to_sym => 'fulano@qa.com',
    "password".to_sym => 'teste'
  }

  login = V1::Login.new
  res = login.send('log_in', '/login', params)

  if res.code == 200
    p 'User logged in'
    @authorization = res.parsed_response['authorization']
    puts "Authorization: #{@authorization}"
  else
    raise "Error: #{res.parsed_response['message']}"
  end
end

Before('@CREATE_PRODUCT') do
  hook_messages('Create product')
  params = {
    "nome".to_sym => 'Produto A',
    "preco".to_sym => 999,
    "descricao".to_sym => 'Descrição do produto A',
    "quantidade".to_sym => 10
  }
end

After('@DELETE_PRODUCT') do
  hook_messages('Delete product')
  res = @product.send('delete_product', "/produtos/#{@buffer_id}")
  if res.code == 200
    p 'Product deleted'
  else
    p 'Product not deleted'
  end
end