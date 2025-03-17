#language: pt

@ALL
@users
Funcionalidade: Usuários

@post
@create_user_without_admin
@DELETE_USER
Cenario: Post - Criar usuário
Dado tenha os parametros "nome", "email", "password" preenchidos com dados validos
E tenha o parametro "administrador" setado como "false"
Quando realizar a requisição "post" para "/usuarios"
Então deve retornar o schema 'usuarios/post' e o status code "201"

@post
@create_user_exist
@DELETE_USER
Cenario: Post - Criar usuário ja existente
Dado tenha um usuario cadastrado
E realize novamente o mesmo cadastro para o mesmo usuario
Quando realizar a requisição "post" para "/usuarios"
Então deve retornar o schema "usuarios/post" e o status code "400"

@get
@get_all_users
Cenario: Get - Buscar todos os usuários
Quando realizar a requisição "get" para "/usuarios"
Então deve retornar o schema "usuarios/get" e o status code "200"

@get
@get_user_by_id
@DELETE_USER
Cenario: Get - Buscar usuário por id
Dado tenha um usuario cadastrado
Quando realizar a requisição "get" para buscar um usuario por id na rota "/usuarios/{id}"
Então deve retornar o schema "usuarios/get_by_id" e o status code "200"