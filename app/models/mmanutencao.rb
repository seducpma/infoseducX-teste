class Mmanutencao < ActiveRecord::Base

  validates_presence_of :unidade_id, :message => ' - SELECIONAR UNIDADE  - '
  belongs_to :unidade, :dependent => :destroy
  belongs_to :situacao_manutencao
  belongs_to :user
  belongs_to :funcionario
  belongs_to :chefia
  has_and_belongs_to_many :tipos_manutencaos
  accepts_nested_attributes_for :unidade
  attr_accessor :tipos_manutencao
  Solicitacao = %w(Internet E-mail Telefone Pessoalmente Outros)

  before_update :data_encerramento

def data_encerramento

  $teste= self.situacao_manutencao.situacao
 if ($teste == 'ENCERRADO')then
      self.data_enc = Time.now
 end

 if ($teste == 'ENCAMINHADO')then
      self.data_ate = Time.now
 end



end



end
