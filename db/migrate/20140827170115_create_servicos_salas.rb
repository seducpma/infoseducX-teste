class CreateServicosSalas < ActiveRecord::Migration
  def self.up
    create_table :servicos_salas do |t|
      t.string :servico
      t.string :obs

      t.timestamps
    end
  end

  def self.down
    drop_table :servicos_salas
  end
end
