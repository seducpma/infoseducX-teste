class OrcUniDespesa < ActiveRecord::Base
  has_many :orc_uni_orcamentaria

   def before_save
    if  !self.descricao.nil?
       self.descricao.upcase!
    end
  end
end
