class ReservarSala < ActiveRecord::Base
  belongs_to :sala
  has_and_belongs_to :servicos_sala
end
