class AcompanhamentoDespacho < ActiveRecord::Base
  belongs_to :acompanhamento,  :dependent => :destroy

   def before_create
    self.funcionario = $usuario
  end
end
