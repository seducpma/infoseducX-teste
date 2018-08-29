class OrcUniOrcamentaria < ActiveRecord::Base
  belongs_to :orc_uni_despesa
  has_many :orc_uni_ficha


  def before_save
    if  !self.descricao.nil?
       self.descricao.upcase!
    end
  end


end
