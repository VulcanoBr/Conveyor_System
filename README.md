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

* Usuarios 
    ```
        vulcano@email.com  password = 123456
        sanurai@email.com  password = 123456 
    ```

* Passos
    1. Criar Categoria
    2. Criar Veiculos
    3. Criar Modalidades
        3.1. Criar Prazos
        3.2. Criar Preços
    4. Criar Ordem de Entrega
    5. Criar Orçamento
    6. Consultar Ordem de Entrega
    7. Encerrar Ordem de Entrega
