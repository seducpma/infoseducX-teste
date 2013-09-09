class Curso < ActiveRecord::Base
  has_and_belongs_to_many :inscricaos
  has_many :unidades
  has_many :participantes
   validates_presence_of :nome, :message => ' ==> PREENCHER DE DADOS OBRIGATÓRIO <=='
   validates_presence_of :ministrante, :message => ' ==> PREENCHER DE DADOS OBRIGATÓRIO <=='

    before_update :encerra_participante


  def before_create
    self.vagas_disponiveis = self.qtde
    if self.nome.present?
      self.nome.upcase
    end
    if self.ministrante.present?
      self.ministrante.upcase
    end
    if self.obs.present?
      self.obs.upcase
    end
  end

  def existe_vaga

    if self.vagas_disponiveis == 0
      false
    else
      true
    end
  end

  
  def encerra_participante

    if status == 1 then
      @inscricaos = Inscricao.find(:all, :include=> :cursos, :conditions => ['cursos.id=?', self.id])

      @inscricaos.each do |inscricao|
    
                inscricao = Inscricao.find_by_id(inscricao)
                #@inscricao.Inscricao.new
                inscricao.encerrado = 1
                y=inscricao.encerrado
                x=inscricao.participante_id
                z=inscricao.id
               inscricao.save
             end


   end

  end


end
