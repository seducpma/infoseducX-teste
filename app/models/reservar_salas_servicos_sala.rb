class ReservarSalasServicosSala < ActiveRecord::Base
  belongs_to :servicos_sala
  belongs_to :reservar_sala
end
