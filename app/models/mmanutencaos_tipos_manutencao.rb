class MmanutencaosTiposManutencao < ActiveRecord::Base
  belongs_to :tipos_manutencao
  belongs_to :mmanutencao

end
