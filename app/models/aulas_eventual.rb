class AulasEventual < ActiveRecord::Base
  belongs_to :eventual
  belongs_to :unidade
  belongs_to :classe
  belongs_to :aulas_falta


  validates_presence_of :eventual_id
  validates_presence_of :unidade_id
  validates_presence_of :aulas_falta_id
  #validates_presence_of :classe_id
  #validates_presence_of :categoria
  #validates_presence_of :periodo
  validates_presence_of :data

end
