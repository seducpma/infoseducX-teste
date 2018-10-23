class CreateOrcReservas < ActiveRecord::Migration
  def self.up
    create_table :orc_reservas do |t|
      t.references :orc_ficha
      t.decimal :valor
      t.date :data
      t.string :motivo
      t.integer :cancela
      t.string :justificativa
      t.date :data
      t.date :data_cancelamento
      t.string :obs

      t.timestamps
    end
  end

  def self.down
    drop_table :orc_reservas
  end
end
