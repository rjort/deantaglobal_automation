@ALL
@users
Feature: Usuários

@post
@create_user_without_admin
@DELETE_USER
Scenario: Post - Create user  
  Given the parameters "nome", "email", "password" are filled with valid data
  And the parameter "administrador" is set to "false"
  When making a "post" request to "/usuarios"
  Then it should return the schema 'usuarios/post' and the status code "201"

@post
@create_user_exist
@DELETE_USER
Scenario: Post - Create existing user
  Given there is a registered user
  And the same registration is made for the same user again
  When making a "post" request to "/usuarios"
  Then it should return the schema "usuarios/post" and the status code "400"

@get
@get_all_users
Scenario: Get - Fetch all users
  When making a "get" request to "/usuarios"
  Then it should return the schema "usuarios/get" and the status code "200"

@get
@get_user_by_id
@DELETE_USER
Scenario: Get - Fetch user by id
Given there is a registered user
When making a "get" request to fetch a user by id on the route "/usuarios/{id}"
Then it should return the schema "usuarios/get_by_id" and the status code "200"
