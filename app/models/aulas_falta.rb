class AulasFalta < ActiveRecord::Base
  belongs_to :professor 
  belongs_to :funcionario
  belongs_to :unidade
  has_one :aulas_eventual, :dependent => :delete

   before_save  :maiusculo

  def maiusculo
    if  !self.funcao.nil?
          self.funcao.upcase!
    end
    if  !self.obs.nil?
          self.obs.upcase!
    end
  end
end
