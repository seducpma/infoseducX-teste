class OrcReserva < ActiveRecord::Base

  usar_como_dinheiro :valor
  belongs_to :orc_ficha
end
