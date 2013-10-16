class TiposManutencao < ActiveRecord::Base
  has_and_belongs_to_many :manutencao
  has_many :unidades
  #has_many :participantes


end
