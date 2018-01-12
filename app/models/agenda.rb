class Agenda < ActiveRecord::Base
  belongs_to :estagiario
  belongs_to :unidade
end
