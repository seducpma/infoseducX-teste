class OrcAta < ActiveRecord::Base
 has_many :orc_ata_items, :dependent => :destroy
end
