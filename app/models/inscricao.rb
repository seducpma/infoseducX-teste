class Inscricao < ActiveRecord::Base

  belongs_to :participante, :dependent => :destroy
  #belongs_to :opcao1, :class_name => 'Unidade', :foreign_key => "opcao1"
  #belongs_to :opcao2, :class_name => 'Unidade', :foreign_key => "opcao2"
  validates_presence_of :existe_vaga?, :message => "Não existe mais vagas dispiveis a este curso"
  has_and_belongs_to_many :cursos
  accepts_nested_attributes_for :participante
  validates_presence_of :participante_id
  #validates_uniqueness_of :participante_id, :if => :tem_inscricao?,:message => " Error => Este participante já efetuou a inscrição"
  attr_accessor :vagas, :curso
  Periodo = %w(Matutino Vespertino Noturno Sabado_Matutino)
  before_save :ativa_inscricao


  def tem_inscricao?
    Inscricao.find_by_participante_id(self.participante_id, :conditions => ['status = 1'])
  end

  def ativa_inscricao

    #status
     #0 - Inscricao finalizada
     #1 - Inscricao em andamento
     self.status = 1
  end

  def existe_vaga?
    cursos = self.cursos
    cursos.each do |curso|
      course = Curso.find(curso)
      t = course.vagas_disponiveis
      course.vagas_disponiveis <= 0 ? false : true
      if course.vagas_disponiveis <= 0 ? true : false
        errors.add(:vagas,"Vagas indisponíveispara o curso #{course.nome_curto}")
      end
    end
  end

  def valida_vaga
    cursos = self.cursos
    cursos.each do |curso|
      course = Curso.find(curso)
      if course.vagas_disponiveis.to_i > 0
        course.vagas_disponiveis = course.vagas_disponiveis.to_i - 1
        t = course.save!
      end
    end
  end

end


