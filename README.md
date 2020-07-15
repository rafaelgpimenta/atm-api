# ATM-API
[![Build Status](https://travis-ci.org/rafaelgpimenta/atm-api.svg?branch=master)](https://travis-ci.org/rafaelgpimenta/atm-api)
[![Maintainability](https://api.codeclimate.com/v1/badges/af3f4100439c5b6fcfc0/maintainability)](https://codeclimate.com/github/rafaelgpimenta/atm-api/maintainability)

A aplicação propõe criar uma API, utilizando o padrão JWT, para reproduzir as ações de um caixa eletrônico inspirado pelo desafio [dojopuzzles.com/problemas/exibe/caixa-eletronico](dojopuzzles.com/problemas/exibe/caixa-eletronico).

As seguintes rotas estão disponíveis:
URL / ENDPOINT       |    VERBO   |    DESCRIÇÃO
-------------------- | ---------- | --------------
/sign_up             |    POST    | Cria um novo cliente com sua respectiva conta bancária e acessa o caixa eletrônico. Deve-se fornecer os campos *cpf* e *password* ao corpo da requisição
/sign_in             |    POST    | Acessa o caixa eletrônico. Deve-se fornecer os campos *cpf* e *password* à requisição
/sign_out            |    POST    | Desconecta do caixa eletrônico
/refresh             |    POST    | Devolve acesso ao caixa eletronico após token ter expirado
/v1/accounts/my      |    GET     | Retorna detalhes sobre a conta bancária do cliente
/v1/transactions/:id |    GET     | Retorna detalhes sobre uma transação específica
/v1/transactions     |    GET     | Retorna todas as transações realizadas na conta do cliente
/v1/transactions     |    POST    | Cria uma nova transação bancária. Deve-se fornecer os campos *kind* ("withdraw" para saque ou "deposit" para depósito) e *amount* (maior que 0)

**Observação:** As requisições de *sign_in* e *sign_up* retornam o token a ser utilizado no header Authorization com a flag Bearer das demais requisições.

Na API temos a resposta em JSON de como o caixa eletrônico deve imprimir as cédulas quando feita uma requisição para criar transação do tipo "withdraw". Abaixo podemos ver um exemplo de como seria a resposta de um saque de 260 reais, nele observamos no campo "printed_value" que foram emitidas duas notas de 100, uma de 50 e uma de 10.

```json
{
  "id": "00000000-0000-0000-0000-000000000000",
  "amount": "260.0",
  "account_id": "00000000-0000-0000-0000-000000000000",
  "kind": "withdraw",
  "details": {
      "printed_value": {
          "100": 2,
          "50": 1,
          "10": 1
      }
  },
  "created_at": "1977-05-25T00:00:00.000Z",
  "updated_at": "1977-05-25T00:00:00.000Z"
}
```

## Dependências

Para executar a aplicação recomenda-se a [instalação do docker-compose](docs.docker.com/compose/install) e utilização do [Postman](www.postman.com) (Na raiz do repositório encontram-se dois arquivos para importar uma collection e um environment)

## Como executar a aplicação

Primeiro execute no seu terminal os seguintes comandos na raiz do projeto para criar o banco de desenvolvimento no postgres:
```
docker-compose build
docker-compose run api rails db:create db:migrate
```

Depois basta executar `docker-compose up` para expor a aplicação no endereço *localhost:3000*

Com a aplicação funcionando, vá até o Postman, [selecione a opção de importar](learning.postman.com/docs/getting-started/importing-and-exporting-data) e busque pelos arquivos *ATM API (dev).postman_environment.json* e *ATM.postman_collection.json* na raiz deste projeto. Em seguida não esqueça de [trocar o ambiente](learning.postman.com/docs/sending-requests/managing-environments). Por fim, envie as requisições e observe as respostas fornecidas em JSON.

## Executar testes unitários

Primeiro execute os seguintes comandos na raiz do projeto para criar o banco de teste no postgres:
```
docker-compose build
docker-compose run api rails db:create db:migrate RAILS_ENV=test
```

Com isso, basta rodar `docker-compose run api rspec`
