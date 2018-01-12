class Chefia < ActiveRecord::Base
  has_many :manutencaos
  has_many :mmanutencaos
  has_many :funcionarios
end