class Certificado < ActiveRecord::Base
  has_many :cursos
  has_many :participantes

end
