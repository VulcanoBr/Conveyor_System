# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

def ambient_standard
  amb = ["sala", "Cozinha", "Quarto", "Banheiro", "Varanda", "Closet", "Suite", "Area de Serviço"]
  7.times do |index|
    AmbientStandard.create!(

        name: amb[index],
        description: "Descrição teste do Texto do Ambiente Standard #{amb[index]}",
        filed: false
    )
  end       
end

def categoria
  cat = ["Bronze", "Prata", "Ouro", "Standard", "Prata Plus", "Ouro Plus", "Bronze Special"]
  7.times do |index|
    Category.create!(

        name: cat[index],
        description: "Descrição teste do Texto da categoria #{cat[index ]}",
        filed: false
    )
  end       
end

def construction_companies
    cnpj = ["12.695.864/0001-54", "83.910.024/0001-05", "70.721.318/0001-47", "02.576.848/0001-99", "33.030.837/0001-32",
            "23.143.421/0001-77", "37.537.641/0001-90", "70.787.645/0001-00", "10.124.046/0001-76", "61.527.829/0001-31"]
    cep = ["76805-854", "89163-095", "76875-552", "64038-255", "79843-320", "29128-260", "70232-535", 
            "26060-640", "95086-210", "54410-695"]
    celular = ["(66) 96956-4474", "(88) 98141-5535", "(83) 99774-8327", "(48) 99183-4987", "(95) 97332-2850", "(87) 98625-5617",
                "(84) 97525-8324", "(82) 98494-7215", "(96) 97193-8911", "(63) 98356-1284", "(69) 98338-6548", "(79) 96744-2618"]
    image = ["engmenor.jpg", "engffff1.jpg", "engcarioca.jpg", "construtora.jpg", "engaaaa.jpg"]
  
    10.times do |index|
    
      ConstructionCompany.create!(
  
        nickname: "Nome fantasia #{index + 1}",
        name: "Nome da Construtora completo #{index + 1}",
        cnpj: cnpj[index],
        institutional_phone: celular[rand(0..11)],
        zipcode: cep[index],
        street: "Nora Jones ",
        neighborhood: "Madureira",
        city: "Rio de Janeiro",
        state: "RJ",
        number: "100",
        complement_number: "Bloco A, 2 andar, sala 205",
        main_contact: "Nome contato principal",
        main_email: "contatomain#{index + 1}@email.com",
        main_phone: celular[rand(0..11)],
        support_conact: "Nome contato suporte",
        support_email: "contatosuporte#{index + 1}@email.com",
        support_phone: celular[rand(0..11)],
        contact: "Nome contato",
        contact_email: "contato#{index + 1}@email.com",
        contact_phone: celular[rand(0..11)],
        status:  0,
        filed: false
        #construction_company.logo.attach(io: File.open("app/assets/images/"+"#{image[rand(0..3)]}"), 
         #       filename: "#{image[rand(0..3)]}",  content_type: "image/jpg")
        )
    end
end

def enterprise
  cc = ConstructionCompany.select(:id).shuffle[0..9]
  cep = ["76805-854", "89163-095", "76875-552", "64038-255", "79843-320", "29128-260", "70232-535", 
            "26060-640", "95086-210", "54410-695"]
  mesano = ["Janeiro 2024", "Fevereiro 2024", "Março 2024", "Abril 2024", "Maio 2024", "Junho 2024", "Julho 2024", "Agosto 2024", 
            "Setembro 2024", "Outubro 2024", "Novembro 2024", "Dezembro 2024", "Janeiro 2025", "Fevereiro 2025", 
            "Março 2025", "Abril 2025", "Maio 2025", "Junho 2025", "Julho 2025", "Agosto 2025", "Setembro 2025"]
  20.times do |index|
    Enterprise.create!(
      name: "Empreendimento #{index + 1} ",
      description: "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. 
        Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero are also reproduced in their exact original form, 
        accompanied by English versions from the 1914 translation by H. Rackham.",
      zipcode: cep[rand(0..9)],
      street: "Nora Jones ",
      neighborhood: "Madureira",
      city: "Rio de Janeiro",
      state: "RJ",
      number: "100",
      complement_number: "Bloco A, 2 andar, sala 205",
      key_delivery_forecast: mesano[rand(0..22)],
      furniture_delivery_forecast: rand(0..2),
      status: 0,
      filed: false,
      construction_company_id: cc[rand(0..9)].id
    )
  end                             
end

def design
  ee = Enterprise.select(:id).shuffle[0..19]
  12.times do |index|
    Design.create!(

      name: "Planta #{index + 1}",
      description: "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. 
        Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero ",
      total_area: rand(90..300),
      amount_environment: rand(4..9),
      number_bedrooms: rand(2..5),
      status: 0,
      filed: false,
      enterprise_id: ee[rand(0..19)].id
    )
  end
end

def ambient 
  xx = []
  dd = Design.select(:id).shuffle[0..11]
  as = AmbientStandard.select(:id).all
  xx = as
  12.times do |index|
      Ambient.create!(
        nickname: "Ambiente #{index + 1}",
        total_area: rand(15..55),
        design_id: dd[rand(0..11)].id,
        ambient_standard_id: as[rand(0..6)].id,
        status: 0,
        filed: false
      )
  end
end

def annoucement
  bb =[], aa = [], ff = []
  cc = Category.select(:id).all
      ff = cc.ids
  10.times do |index|
      aa = Ambient.select(:id, :design_id, :nickname).shuffle[0..11]
      xx = aa[rand(0..11)]
      dd = Design.select(:id, :enterprise_id, :name).where(id: xx.design_id)
      bb = dd
      ee = Enterprise.select(:id, :construction_company_id, :name).where(id: bb[0].enterprise_id)
      aa = ee
      price = rand(2010..19000) + 0.51
      cat = ff[rand(0..6)]
      Annoucement.create!(
        ambient_id: xx.id,
        design_id: xx.design_id,
        construction_company_id: aa[0].construction_company_id,
        enterprise_id: bb[0].enterprise_id,
        category_id: cat,
        annoucement_summary: "The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested. 
        Sections 1.10.32 and 1.10.33 from de Finibus Bonorum et Malorum by Cicero ",
        total_price: price,
        discount_value: 0.00,
        percentage_discount: 0.00,
        final_price:  price,
        filed: false
      )

  end
end

Annoucement.destroy_all
Ambient.destroy_all
Design.destroy_all
Enterprise.destroy_all
ConstructionCompany.destroy_all

AmbientStandard.destroy_all
ambient_standard()

Category.destroy_all
categoria()


construction_companies()


enterprise()


design()


ambient()


#annoucement()