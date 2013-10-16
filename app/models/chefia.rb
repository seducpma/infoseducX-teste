class Chefia < ActiveRecord::Base
  has_many :manutencaos
  has_many :funcionarios
end