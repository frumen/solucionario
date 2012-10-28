namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    Country.create!(name:'Andorra')
    Country.create!(name:'Argentina')
    Country.create!(name:'Bolivia')
    Country.create!(name:'Colombia')
    Country.create!(name:'Costa Rica')
    Country.create!(name:'Cuba')
    Country.create!(name:'Chile')
    Country.create!(name:'Ecuador')
    Country.create!(name:'Espana')
    Country.create!(name:'Guatemala')
    Country.create!(name:'Honduras')
    Country.create!(name:'Mexico')
    Country.create!(name:'Nicaragua')
    Country.create!(name:'Panama')
    Country.create!(name:'Paraguay')
    Country.create!(name:'Peru')
    Country.create!(name:'Republica Dominicana')
    Country.create!(name:'Puerto Rico')
    Country.create!(name:'El Salvador')
    Country.create!(name:'Uruguay')
    Country.create!(name:'Venezuela')
    admin = User.create!(name: "Fede",
                 surname: "Frumento",
                 email: "federicofrumento21@hotmail.com",
                 password: "estabamos",
                 password_confirmation: "estabamos",
                 score: 100,
                 country_id: 2,
                 sex: "M",
                 birth: '1990-04-10',
                 confirmed: 1)
    admin.toggle!(:admin)
    5.times do |n|
      name  = Faker::Name.name
      email = "pirulo#{n+1}@pirulo.com"
      password  = "estabamos"
      country = n+3
      User.create!(name: name,
                   surname: "Perez",
                   email: email,
                   password: password,
                   password_confirmation: password,
                   country_id: country,
                   sex: "M",
                   birth: '1985-12-05',
                   confirmed: 1)
    end
    Area.create!(name:'Negocios')
    Area.create!(name:'Tecnologia e Internet')
    Area.create!(name:'Economia')
    Area.create!(name:'Educacion')
    Area.create!(name:'Automoviles')
    Area.create!(name:'Casa y Jardin')
    Area.create!(name:'Deportes')
    Area.create!(name:'Gastronomia')
    Area.create!(name:'Sociedad y Cultura')
    Area.create!(name:'Turismo')
    Area.create!(name:'Humanidades')
    Area.create!(name:'Ciencias e Ingenieria')
    Area.create!(name:'Arte y Ocio')
    5.times do |n|
      user  = User.find(n+1)
      user.area_users.create!(area_id: n+1)
    end
    5.times do |n|
      titulo  = "Tiulo#{n+1}"
      contenido = "contenido#{n+1}"
      Question.create!(title: titulo,
                   content: contenido,
                   user_id: n+1,
                   area_id: n+1,
                   level: 1)
    end
  end
end