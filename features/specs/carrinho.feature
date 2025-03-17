#language: pt

@ALL
@cart
Funcionalidade: Carrinho

@post
@add_product_to_cart
Cenario: Adicionar um produto ao carrinho
Dado tenha um produto cadastrado
E realize uma requisição "post" para "/carrinho"
Quando realizar a requisição "post" para "/carrinho"
Entao deve retornar o schema "carrinho/post" e o status code "200"

@get
@get_cart
Cenario: Buscar carrinho
Quando realizar a requisição "get" para "/carrinho"
Entao deve retornar o schema "carrinho/get" e o status code "200"

@delete
@cart_complete
Cenario: Concluir carrinho
Dado tenha um carrinho cadastrado com produtos
E realize uma requisição "delete" para "/carrinhos/concluir-compra"
Quando realizar a requisição "delete" para "/carrinho"
Entao deve retornar o schema "carrinho/delete" e o status code "200"

@delete
@cart_cancel
Cenario: Cancelar carrinho
Dado tenha um carrinho cadastrado com produtos
E realize uma requisição "delete" para "/carrinhos/cancelar-compra"
Quando realizar a requisição "delete" para "/carrinho"