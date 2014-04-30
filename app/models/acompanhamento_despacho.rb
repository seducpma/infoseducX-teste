class AcompanhamentoDespacho < ActiveRecord::Base
  belongs_to :acompanhamento,  :dependent => :destroy
  
end
