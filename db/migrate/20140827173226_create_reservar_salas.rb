class CreateReservarSalas < ActiveRecord::Migration
  def self.up
    create_table :reservar_salas do |t|
      t.references :sala
      t.datetime :data_reserva
      t.datetime :horario_reserva
      t.string :utilizacao
      t.string :solicitante
      t.string :obs

      t.timestamps
    end
  end

  def self.down
    drop_table :reservar_salas
  end
end
