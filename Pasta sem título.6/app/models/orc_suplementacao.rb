class OrcSuplementacao < ActiveRecord::Base
  belongs_to :orc_ficha
  usar_como_dinheiro :valor_suplemento

end
