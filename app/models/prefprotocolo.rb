class Prefprotocolo < ActiveRecord::Base
 has_many :despachos

 validates_presence_of :de, :assunto, :para, :destino, :message => ' - PREENCHIMENTO OBRIGATÓRIO'

  PARA = %w(APROVAÇÃO ARQUIVAR ASSINAR ATUALIZAÇÃO CADASTRAMENTO
CIÊNCIA_E_PROVIDÊNCIA CONHECIMENTO_E_CIÊNCIA CONHECIMENTO_E_MANIFESTAÇÃO
CORREÇÃO DESAPENSAMENTO DESTRATAMENTO DISTRIBUIÇÃO ELABORAR_DOCUMENTO ELABORAR_PORTARIA ELABORAR_PROCESSO
EM_DEVOLUÇÃO ENCAMINHAMENTO_LEGISLAÇÃO ENCERRADO FALTA_DOCUMENTO FINALIZAÇÃO FORMAR_PROCESSO
FORMAR_VOLUME INFORMAÇÃO JUNTADO_EM_DEVOLUÇÃO JUNTAR_DOCUMENTO
MANIFESTAÇÃO_LEGAL MANIFETAÇÃO NOTIFICAÇÃO PROCESSO_JUNTADO
PROSSEGUIMENTO PROVIDÊNCIAS PUBLICAÇÃO RESPOSTA_OFÍCIO RESPOSTA_REQUERIMENTO
RETIRADA SEPARAÇÃO_DOCUMENTO SOLICITAÇÃO)

  DESTINO = %w(EDUCAÇÃO_INFANTIL EDUCAÇÂO_FUNDAMENTAL COMPRAS CONTABILIDADE GABINETE
INFORMÁTICA MANUTENÇÃO PLANEJAMENTO PROTOCOLO_INTERNO RECURSOS_HUMANOS )

def before_save
    self.de.upcase!
    self.assunto.upcase!
    self.para.upcase!
    self.destino.upcase!
#    self.obs.upcase!
end


end
