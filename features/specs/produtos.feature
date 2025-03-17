#language: pt

@ALL
@Login
@products
Funcionalidade: Produtos

@put
@update_product
@DELETE_PRODUCT
Cenario: Atualizar um produto
Dado tenha um produto cadastrado
Quando realizar a requisição "put" para "/produtos/{id}" na rota de produtos
Entao deve retornar o schema de produtos em "produtos/put" e o status code "200"

@delete
@delete_product
Cenario: Deletar um produto
Dado tenha um produto cadastrado
Quando realizar a requisição "delete" para "/produtos/{id}" na rota de produtos
Entao deve retornar o schema de produtos em "produtos/delete" e o status code "200"

@delete
@delete_not_exists
Cenario: Deletar um produto que não existe
Dado tenha um id que não existe
Quando realizar a requisição "delete" para "/produtos/{id}" na rota de produtos
Entao deve retornar o schema de produtos em "produtos/delete" e o status code "200"
