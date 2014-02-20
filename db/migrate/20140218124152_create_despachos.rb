class CreateDespachos < ActiveRecord::Migration
  def self.up
    create_table :despachos do |t|
      t.references :prefprotocolo
      t.string :procedencia
      t.datetime :data_recebimento
      t.string :para
      t.string :despacho
      t.string :destino
      t.datetime :data_saida

      t.timestamps
    end
  end

  def self.down
    drop_table :despachos
  end
end
