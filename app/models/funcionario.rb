class Funcionario < ActiveRecord::Base

has_many :manutencaos
belongs_to :chefia


end
