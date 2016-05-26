load 'controllers/controller.rb'
class ProdutoController < Controller
  def initialize
    @entity_name = 'produto'
    config
  end

end
