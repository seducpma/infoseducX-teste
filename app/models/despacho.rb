class Despacho < ActiveRecord::Base
  belongs_to :prefprotocolo, :dependent => :destroy

end
