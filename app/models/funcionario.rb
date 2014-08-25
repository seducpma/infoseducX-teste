class Funcionario < ActiveRecord::Base

has_many :manutencaos
has_many :mmanutencaos
belongs_to :chefia


end
