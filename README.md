# ATM-API

A aplicação propõe criar uma API, utilizando o padrão JWT, para reproduzir as ações de um caixa eletrônico inspirado pelo desafio [dojopuzzles.com/problemas/exibe/caixa-eletronico](dojopuzzles.com/problemas/exibe/caixa-eletronico).

As seguintes rotas estão disponíveis:
- **POST /sign_up** -> Cria um novo cliente com sua respectiva conta bancária e acessa o caixa eletrônico. Deve-se fornecer os campos *cpf* e *password* à requisição
- **POST /sign_in** -> Acessa o caixa eletrônico. Deve-se fornecer os campos *cpf* e *password* à requisição
- **POST /sign_out** -> Desconecta do caixa eletrônico
- **GET /v1/accounts/my** -> Retorna detalhes sobre a conta bancária do cliente
- **GET /v1/transactions** -> Retorna todas as transações realizadas na conta do cliente
- **POST /v1/transactions** -> Cria uma nova transação bancária. Deve-se fornecer os campos *kind* ("withdraw" para saque ou "deposit" para depósito) e *amount* (maior que 0)
- **GET /v1/transactions/:uuid** -> Retorna detalhes sobre uma transação específica

**Observação:** As requisições de *sign_in* e *sign_up* retornam o token a ser utilizado no header Authorization com a flag Bearer das demais requisições.

## Dependências

Para executar a aplicação recomenda-se a [instalação do docker-compose](docs.docker.com/compose/install) e utilização do [Postman](www.postman.com) (Na raiz do repositório encontram-se dois arquivos para importar uma collection e um environment)

## Como executar a aplicação

Primeiro execute com seu terminal os seguintes comandos na raiz do projeto:
```
docker-compose build
docker-compose run api rails db:create db:migrate
```

Depois basta executar `docker-compose up`

Com a aplicação funcionando, vá até o Postman, selecione a opção de importar e busque pelos arquivos *ATM API (dev).postman_environment.json* e *ATM.postman_collection.json* na raiz deste projeto. Em seguida não esqueça de [trocar o ambiente](learning.postman.com/docs/sending-requests/managing-environments). Por fim, envie as requisições e observe as respostas fornecidas em JSON.

## Executar testes unitários

Primeiro execute os seguintes comandos na raiz do projeto:
```
docker-compose build
docker-compose run api rails db:create db:migrate RAILS_ENV=test
```

Com isso, basta rodar `docker-compose run api rspec`
