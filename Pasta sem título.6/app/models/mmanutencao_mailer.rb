class MmanutencaoMailer < ActionMailer::Base

def notificar_mmanutencao(mmanutencao)
  recipients mmanutencao.user.email
  subject "Protocolo Manutenção"
  from  "administrador@seducpma.com"
  
  body :mmanutencao => mmanutencao
end

end
