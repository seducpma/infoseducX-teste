class AulasFalta < ActiveRecord::Base
  belongs_to :professor 
  belongs_to :funcionario
  belongs_to :unidade
  has_one :aulas_eventual, :dependent => :destroy
  before_save  :maiusculo

  validates_presence_of :professor_id
  #validates_presence_of :data
  validates_presence_of :tipo
  validates_presence_of :unidade_id
  validates_presence_of :funcao
  validates_presence_of :setor
  #validates_presence_of :periodo

    	


  def maiusculo
    if  !self.funcao.nil?
          self.funcao.upcase!
    end
    if  !self.obs.nil?
          self.obs.upcase!
    end
  end
end
