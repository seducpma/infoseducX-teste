class Curriculo < ActiveRecord::Base

validates_uniqueness_of   :RG, :CPF

CIVIL = %w(SOLTEIRO(A) CASADO(A) VIÚVO(A) SEPARADO(A) DIVORCIADO(A) OUTRO(A))
PERIODO = %w(MATUTINO VESPERTINO NOTURNO INTEGRAL)
SEMESTRE = %w(1ºSEMESTRE 2ºSEMESTRE 3ºSEMESTRE 4ºSEMESTRE 5ºSEMESTRE 6ºSEMESTRE 7ºSEMESTRE 8ºSEMESTRE 9ºSEMESTRE 10ºSEMESTRE)
STATUS = %w(CONTRATADO NIVEL-0 NIVEL-1 NIVEL-2 NIVEL-3)

 def before_save
    self.nome.upcase!
    self.endereco.upcase!
    self.complemento.upcase!
    self.bairro.upcase!
    self.cidade.upcase!
    self.instituicao.upcase!
    self.curso.upcase!
    self.pergunta1.upcase!
    self.pergunta2.upcase!
    self.pergunta3.upcase!
    self.obs.upcase!
end


end
