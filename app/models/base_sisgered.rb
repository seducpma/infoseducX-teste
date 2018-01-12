class BaseSisgered < ActiveRecord::Base

  self.abstract_class = true
  establish_connection "basesisgered_#{RAILS_ENV}"

end





