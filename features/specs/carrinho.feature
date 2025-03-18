
@cart
Feature: Carrinho

@post
@add_product_to_cart
Scenario: Add a product to the cart  
Given there is a registered product  
When making a "post" request to "/carrinho" on the cart route  
Then it should return the cart schema in "carrinho/post" and the status code "200"

@get
@get_cart
Scenario: Retrieve cart  
When making a "get" request to "/carrinho"  
Then it should return the cart schema in "carrinho/get" and the status code "200"

@delete
@cart_complete
Scenario: Complete cart  
Given there is a registered cart with products  
When making a "delete" request is made to "/carrinhos/concluir-compra"  
Then it should return the cart schema in "carrinho/delete" and the status code "200"

@delete
@cart_cancel
Scenario: Cancel cart  
Given there is a registered cart with products  
When making a "delete" request to "/carrinhos/cancelar-compra"  
Then it should return the cart schema in "carrinho/delete" and the status code "200"