class CreateMmanutencaosTiposManutencaos < ActiveRecord::Migration
  def self.up
    create_table :mmanutencaos_tipos_manutencaos do |t|
      t.references :tipos_manutencao
      t.references :mmanutencao

      t.timestamps
    end
  end

  def self.down
    drop_table :mmanutencaos_tipos_manutencaos
  end
end
