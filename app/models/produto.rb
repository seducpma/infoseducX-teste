class Produto < ActiveRecord::Base
has_many :produtos_lancamentos
  before_save  :maiusculo

  def maiusculo
    if  !self.produto.nil?
          self.produto.upcase!
    end
    if  !self.fornecedor.nil?
          self.fornecedor.upcase!
    end
    if  !self.nf.nil?
          self.nf.upcase!
    end
    if  !self.complemento.nil?
          self.complemento.upcase!
    end
    if  !self.obs.nil?
         self.obs.upcase!
    end
  end

end
