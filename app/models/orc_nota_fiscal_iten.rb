class OrcNotaFiscalIten < ActiveRecord::Base
  belongs_to :orc_nota_fiscal
  

    usar_como_dinheiro :unitario, :total, :total_geral, :subtotal
     def maiusculo
    if  !self.descricao.nil?
          self.descricao.upcase!
    end


  end

end
