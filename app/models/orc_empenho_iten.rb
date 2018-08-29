class OrcEmpenhoIten < ActiveRecord::Base
  belongs_to :orc_empenho


    usar_como_dinheiro :unitario, :total, :total_geral
end
