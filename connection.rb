require 'sinatra/activerecord'
ActiveRecord::Base.
  establish_connection(
    :adapter => 'postgresql',
    :database =>  'estoque',
    :user => 'postgres',
    :password => 'postgres'
)

