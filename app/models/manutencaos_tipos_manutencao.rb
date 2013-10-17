class ManutencaosTiposManutencao < ActiveRecord::Base
  belongs_to :tipos_manuntencao
  belongs_to :manutencao
end
