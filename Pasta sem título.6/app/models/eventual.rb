class Eventual < ActiveRecord::Base
  belongs_to :professor
   belongs_to :unidade
   before_save :caps_look

    validates_presence_of :professor_id
    validates_presence_of :unidade_id
    validates_presence_of :disponibilidade
    validates_presence_of :periodo
    validates_presence_of :categoria




 def caps_look
    if  !self.disponibilidade.nil?
          self.disponibilidade.upcase!
    end
    if  !self.obs.nil?
          self.obs.upcase!
    end

  end


end
