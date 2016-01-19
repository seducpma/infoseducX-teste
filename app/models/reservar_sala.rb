class ReservarSala < ActiveRecord::Base
  belongs_to :sala
    belongs_to :unidade
  has_and_belongs_to_many :servicos_salas
  attr_accessor :servicos_sala

  validates_presence_of :sala_id

end
