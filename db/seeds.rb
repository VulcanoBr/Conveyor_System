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
    User.create!(name: "Sanurai", email: "sanurai@email.com", password: 123456)
end

# Tabela de Categoria
def Categoria
    cat = ["Carro", "2 Rodas", "Caminhão Toco", "Furgão", "VUC", "Van", "Truck"]
    7.times do |index|
      Category.create!(
  
          name: cat[index]
      )
    end       
end

#Tabela de Veiculos
def Car 
    fabricante = ["Suzuki", "Fiat", "Ford", "Chevrolet", "Honda", "Hunday", "Citroen", "Renault"]
    p = Category.select(:id).shuffle[0..6]
    v = Vehicle.select(:id).shuffle[0..19]
    50.times do |index|
      Vehicle.create!(
            nameplate: SecureRandom.alphanumeric(8).upcase, 
            brand: fabricante[rand(0..7)],
            vehicle_model: "Modelo  #{index}",
            year_manufacture: rand(2015..2023), 
            maximum_load: rand(10..14000),
            status: 0,
            category_id: p[rand(0..6)].id)
    end
end
  
# Tabela de Modalidade, Preço e Prazo
def Modalidade
    mod = ["Carga Rapida", "Carga Expressa", "Carga Pesada", "Caraga Interestadual", "Carga Intermunicipal", "Leva e Traz",
            "Carga Leve" ] 

    7.times do |index|
        ModeTransport.create!(
            name: mod[index],
            minimum_distance: 0,
            maximum_distance: rand(50..1300),
            minimum_weight: 0,
            maximum_weight: rand(10..100),
            delivery_fee: rand(30..200),
            status: 0
        )
    end

        mt = ModeTransport.all
        mt.each do |ind|
            startkg = 0 
            finalkg = 18
            km = 50
            6.times do |indx|
                Price.create!(
                    start_weight: startkg,
                    final_weight: finalkg,
                    km_price: km,
                    mode_transport_id: ind.id)
                
                startkg = finalkg + 1
                finalkg += 18
                km += 70
            end
        end
        mt1 = ModeTransport.all
        
        mt1.each do |i|
            startkm = 0
            finalkm = 100
            hs = 24
            6.times do |indx|
                Deadline.create!(
                    start_distance: startkm,
                    final_distance: finalkm,
                    deadline_hours: hs,
                    mode_transport_id: i.id)
                
                startkm = finalkm + 1
                indx > 3 ? finalkm += 350 : finalkm += 200
                indx > 3 ? hs += 48 : hs += 24
                
            end
        end
end

# Tabela Ordem de Entrada
def Order 
    user = User.select(:id).shuffle[0..1]
    end1 = ["Rua", "Avenida", "Estrada", "Travessa", "Praça"]
    end2 = ["São Cristovão", "Samuel Rosa", "Santa Clara", "Treze de Março", "XV de Julho", "São Salvador", "Maria Cristina",
            "Treze de Maio", "Bolçao Azul", "Hilda Magalhâes"]
    
    end3 = ["Freguesia", "Jabaguara", "Macarena", "Matheuzinho", "Silva Jardim", "Tatuape", "Taquara", "Ilha Raza", 
            "Noronha", "Cascadura"]
    end4 = ["Campina Grande", "Santos", "Maringa", "Dourados", "Macapa", "Nova Aurora", "Cruz Azul", "Ribeirão Preto", 
            "Alagoinhas", "Vila Azul"]
    end5 = ["MT", "RD", "MA", "AP", "SC", "GO", "PB", "RN", "PE", "SP"]
    sender = ["Carlos Magno", "Josival Santos", "Matia Cristina", "Juliana Silva", "Fernando Sanches", 
                  "Marcio Nogueira", "Kamila Campelo", "Tainara Terica", "Ramom Dias", "Valeria Kurusawa"]
    recepient = ["Mendes Alves", "Mirian Novaes", "Julia Mesquita", "Carla Cristina", "Albuquerque Silva",
                   "Marlon Dias", "Deyse Samuel", "Clara Marcondes", "Sibila Amaral", "366.867.723-99Jackson Mendes"]
    sender_ident = ["266.495.742-28", "488.554.557-96", "504.648.082-43", "186.426.234-62", "366.867.723-99",
              "25.446.403/0001-90", "94.484.939/0001-12", "59.341.035/0001-37", "85.232.721/0001-80" ]
    recipient_ident = ["675.578.970-48", "048.007.900-50", "895.591.420-20", "337.287.160-06", "194.155.970-03",
                "63.342.153/0001-37", "40.976.052/0001-12", "98.477.137/0001-36", "59.988.115/0001-89"]
    sender_cep = ["69309-388", "57046-280", "76811-516", "74583-037", "54756-055", "76812-158",
                  "25740-042", "66633-700", "82960-490", "72811-100"]
    recipient_cep = ["57080-603", "45012-030", "65092-440", "53640-360", "69900-388", "77060-300",
                      "53650-040", "77006-146", "23912-535", "59603-245"]
    20.times do |index|
        Order.create!(
            code: SecureRandom.alphanumeric(15).upcase,
            product_code: SecureRandom.alphanumeric(8).upcase,
            height: rand(10..100),
            width: rand(30..150),
            depth: rand(5..50),
            weight: rand(8..100),
            description: "descrição padrão #{index + 1}",
            distance: rand(80..1400),
            sender_name: sender[rand(0..9)],
            sender_identification: sender_ident[rand(0..8)],
            sender_email: "#{SecureRandom.alphanumeric(6)}@email.com",
            sender_phone: "(#{rand(11..88)}) #{rand(11111..99999)}-#{rand(1111..9999)}",
            sender_address: "#{end1[rand(0..4)]} #{end2[rand(0..9)]}", 
            sender_number: "#{rand(23..400)}",
            sender_complement: "", 
            sender_neighborhood: "#{end3[rand(0..9)]}",
            sender_city: end4[rand(0..9)],
            sender_state: end5[rand(0..9)],
            sender_zipcode: sender_cep[rand(0..9)],
            recipient_name: recepient[rand(0..9)],
            recipient_identification: recipient_ident[rand(0..8)],
            recipient_email: "#{SecureRandom.alphanumeric(6)}@email.com",
            recipient_phone: "(#{rand(11..88)}) #{rand(11111..99999)}-#{rand(1111..9999)}", 
            recipient_address: "#{end1[rand(0..4)]} #{end2[rand(0..9)]}",
            recipient_number: "#{rand(23..400)}",
            recipient_complement: "",
            recipient_neighborhood: "#{end3[rand(0..9)]}",
            recipient_city: end4[rand(0..9)],
            recipient_state: end5[rand(0..9)],
            recipient_zipcode: recipient_cep[rand(0..9)],
            status: 0,
            user_id: user[rand(0..1)].id)
    end
end

Order.destroy_all
User.destroy_all
Usuario()

Vehicle.destroy_all
Category.destroy_all
Categoria()


Car()

Deadline.destroy_all
Price.destroy_all
ModeTransport.destroy_all
Modalidade()

Order()