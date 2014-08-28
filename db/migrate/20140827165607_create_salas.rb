class CreateSalas < ActiveRecord::Migration
  def self.up
    create_table :salas do |t|
      t.string :sala
      t.string :descricao
      t.string :localizacao
      t.string :obs

      t.timestamps
    end
  end

  def self.down
    drop_table :salas
  end
end
