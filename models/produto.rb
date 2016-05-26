class Produto < ActiveRecord::Base
  self.table_name = "produtos"
  belongs_to :categoria
end
