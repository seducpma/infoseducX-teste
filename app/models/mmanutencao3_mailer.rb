class Mmanutencao3Mailer < ActionMailer::Base


#def confirmacao_inscricao(inscricao,participante)
#  recipients participante.email
#  subject "Texto"
#  from  "administrador@seducpma.com"
#  body :participante => participante, :inscricao => inscricao
#end


def enviar_email(mmanutencao,email)
  recipients email
  subject "Texto"
  from  "no-replay@seducpma.com"
  #body :participante => participante, :inscricao => inscricao
  body :email => email, :mmanutencao => mmanutencao
end

end
