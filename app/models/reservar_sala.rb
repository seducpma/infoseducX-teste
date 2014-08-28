class ReservarSala < ActiveRecord::Base
  belongs_to :sala
  belongs_to :servico
end
