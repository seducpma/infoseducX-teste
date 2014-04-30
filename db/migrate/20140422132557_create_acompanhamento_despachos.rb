class CreateAcompanhamentoDespachos < ActiveRecord::Migration
  def self.up
    create_table :acompanhamento_despachos do |t|
      t.references :despacho
      t.string :despacho
      t.datetime :data
      t.string :obs

      t.timestamps
    end
  end

  def self.down
    drop_table :acompanhamento_despachos
  end
end
