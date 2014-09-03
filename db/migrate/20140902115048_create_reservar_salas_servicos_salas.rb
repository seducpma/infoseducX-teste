class CreateReservarSalasServicosSalas < ActiveRecord::Migration
  def self.up
    create_table :reservar_salas_servicos_salas do |t|
      t.references :servicos_sala
      t.references :reservar_sala

      t.timestamps
    end
  end

  def self.down
    drop_table :reservar_salas_servicos_salas
  end
end
