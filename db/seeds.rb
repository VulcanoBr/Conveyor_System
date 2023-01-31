# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Tabela de Usuario
def Usuario
    User.create!(name: "Vulcano", email: "vulcano@email.com", password: 123456)
end

# Tabela de Categoria
def categoria
    cat = ["Carro", "2 Rodas", "Caminhão Toco", "Furgão", "VUC", "Van", "Truck"]
    7.times do |index|
      Category.create!(
  
          name: cat[index]
      )
    end       
end

#Tabela de Veiculos

# Tabela de Modalidade
