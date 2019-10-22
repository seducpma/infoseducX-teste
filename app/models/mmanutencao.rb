class Mmanutencao < ActiveRecord::Base

  validates_presence_of :unidade_id, :message => ' - SELECIONAR UNIDADE  - '
  belongs_to :unidade, :dependent => :destroy
  belongs_to :situacao_manutencao
  belongs_to :user
  belongs_to :funcionario
  belongs_to :chefia
  has_and_belongs_to_many :tipos_manutencaos
    #has_attached_file :photo, :styles => {:thumb=> "100x100#", :small  => "150x150>" }
      has_attached_file :photo, :styles => {:original=> "300x300>"},
                    :url => "/photos/mmanutencaos/:id.:extension",
                    :path => ":rails_root/public/photos/mmanutencaos/:id.:extension"


  accepts_nested_attributes_for :unidade
  attr_accessor :tipos_manutencao
  Solicitacao = %w(Internet E-mail Telefone Pessoalmente Outros)
  
  before_update :data_encerramento

def data_encerramento

  $teste= self.situacao_manutencao.situacao
 if ($teste == 'ENCERRADO')then
      if self.chefia_id == 1
        self.data_ate = Time.now
      else
        self.data_enc = Time.now
      end
 end

 if ($teste == 'ENCAMINHADO')then
      if self.chefia_id == 1
        
      else
        self.data_ate = Time.now
      end
 end
end

 def self.nome_unidade(unidade)
    Unidade.find(unidade).nome
  end


def self.aberto_geral
    Mmanutencao.find(:all, :conditions => ['situacao_manutencao_id = 2'])
end

def self.encerrado_geral
    Mmanutencao.find(:all, :conditions => ['situacao_manutencao_id <> 2'])
end

def self.geral
    Mmanutencao.find(:all)
end

#======== POR UNIDADE

def self.aberto_unidade(unidade)
    unidade_id = Unidade.find(unidade).id
    Mmanutencao.find(:all, :conditions => ['unidade_id=? AND situacao_manutencao_id = 2',unidade_id])
end

def self.encerrado_unidade(unidade)
    unidade_id = Unidade.find(unidade).id
    Mmanutencao.find(:all, :conditions => ['unidade_id=? AND situacao_manutencao_id <> 2',unidade_id] )
end

def self.por_unidade(unidade)
     unidade_id = Unidade.find(unidade).id
    Mmanutencao.find(:all, :conditions => ['unidade_id = ?', unidade_id])
end
end
