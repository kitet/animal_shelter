require "pg"
require "sinatra"
require "sinatra/reloader"
require "./lib/animal"
require "./lib/customer"
also_reload("lib/**/*.rb")

DB=PG.connect :dbname => 'animal_shelter'

get '/' do
  @animals=Animal.all
  @customers=Customer.all
  erb :index
end

post '/index/new/animal' do
  name=params.fetch('name')
  gender_input=params.fetch('gender')
  gender_input.eql?("0") ? gender=false : gender=true
  doa=params.fetch('doa')
  type=params.fetch('type')
  breed=params.fetch('breed')
  new_animal=Animal.new({:id=>0,:name=>name,:gender=>gender,:doa=>doa,:type=>type,:breed=>breed})
  new_animal.save
  @animals=Animal.all
  @customers=Customer.all
  erb :index
end

post '/index/new/customer' do
  name=params.fetch('name')
  phone=params.fetch('phone')
  type=params.fetch('type')
  breed=params.fetch('breed')
  new_customer=Customer.new({:id=>0,:name=>name,:phone=>phone,:type_pref=>type,:breed_pref=>breed})
  new_customer.save
  @animals=Animal.all
  @customers=Customer.all
  erb :index
end

get '/animal/:id' do
  @animal=Animal.find(params.fetch('id').to_i())
  @i_customers=Customer.find_by_breed(@animal.breed, @animal.type)
  erb :animal
end

patch '/animal/:id' do
  @animal=Animal.find(params.fetch('id').to_i())
  customer_id=params.fetch('select').to_i()
  @animal.update_owner(customer_id)
  redirect '/'
end
