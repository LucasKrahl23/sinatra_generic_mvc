# server.rb
load 'sinatra_base.rb'
class Server < SinatraBase
  resources_all({
    categoria: CategoriaController.new.helpers,
    produto: ProdutoController.new.helpers
  })

  run!
end

# $> ruby server.rb
