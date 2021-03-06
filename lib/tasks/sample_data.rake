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
  end
end