
@ALL
@Login
@products
Feature: Produtos

@put
@update_product
@DELETE_PRODUCT
Scenario: Update a product
  Given there is a registered product
  When making a "put" request to "/produtos/{id}" on the products route
  Then it should return the products schema in "produtos/put" and the status code "200"

@delete
@delete_product
Scenario: Delete a product
Given there is a registered product
When making a "delete" request to "/produtos/{id}" on the products route
Then it should return the products schema in "produtos/delete" and the status code "200"

@delete_not_exists
@delete
Scenario: Delete a product that does not exist
Given that there is an id that does not exist
When making a "delete" request to "/produtos/{id}" on the products route
Then it should return the products schema in "produtos/delete" and the status code "200"
