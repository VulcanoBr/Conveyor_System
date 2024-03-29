# README

## Sobre o projeto
Esta aplicação e responsável por gerenciar a frota de entrega de uma transportadora com alcance nacional. Diferentes modalidades de transporte são cadastradas definindo prazos, custos e veículos disponíveis para cada uma delas; e calcular prazos e custos para o transporte de um determinado produto  em um  endereço, em diferentes modalidades.

### Requisitos Necessários:
* Gem
    * Ruby 3.1.2
    * Rails 7.0.4
    * Devise
    * Bootstrap 5.2
    * Rspec-rails
    * Simplecov
    * cpf_cnpj
    

* Banco de Dados:
    * Sqlite3

### Funcionalidades
* Cadastros
    * Categoria
    * Veiculos
    * Modalidades


* Pedidos
    * Criar Ordem de Entrega
    * Consulta Orçamento
    * Consulta Ordem de Entrega
    * Encerrar Ordem de Entrega

### Para executar o projeto: 

* Git Clone
    ```
        https://git-qsd.campuscode.com.br/VulcanoBr/conveyor-system.git 
    ```

* Atualizar
    ```
        cd conveyor_system
        bundle install
    ```

* Gerar banco de dados
    ```
        rails db:create
        rails db:migrate
        rails db:seed 
    ``` 

* Execute a aplicação
    ```
        rails s 
    ```

### Iniciando o projeto com Docker

Após iniciar o projeto com os passos acima (exceto "Execute a aplicação")


* Execute o seguinte comando para criar a imagem
```
    sudo docker build -t conveyor_system:v1 .
```

* Execute o seguinte comando para subir o container em segundo plano.
```
    sudo docker run -p 3000:3000 -d --name conveyor_system conveyor_system:v1
```

* Acesse o navegador com o seguinte endereço
```
    http://localhost:3000/
```

* Rode o comando abaixo para parar o container
```
sudo docker stop conveyor_system
```

### Acesso ao sistema
* Usuarios 
    ```
        vulcano@email.com  password = 123456
        sanurai@email.com  password = 123456 
    ```

* Passos
    1. Criar Categoria
    2. Criar Veiculos
    3. Criar Modalidades
        1. Criar Prazos
        2. Criar Preços
    4. Criar Ordem de Entrega
    5. Criar Orçamento
    6. Consultar Ordem de Entrega
    7. Encerrar Ordem de Entrega

