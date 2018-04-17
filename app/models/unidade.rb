class Unidade < BaseSisgered


  belongs_to :tipo
  has_many :professors
  has_many :eventuals
  has_many :classes
  has_many :users
  has_many :aulas_faltas
  has_many :estagiarios
  has_many :mmanutencaos
  has_many :chamados
  has_many :poda_gramas
  
end
