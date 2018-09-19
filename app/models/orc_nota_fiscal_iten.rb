class OrcNotaFiscalIten < ActiveRecord::Base
  belongs_to :orc_nota_fiscal
   has_many :orc_nota_fiscal_itens, :dependent => :destroy
end
