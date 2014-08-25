class CreateManutencaos < ActiveRecord::Migration
  def self.up
    create_table :manutencaos do |t|
      t.references :situacao_manutencao
      t.references :funcionario
      t.references :chefia
      t.references :user
      t.string :descricao
      t.datetime :data_sol
      t.datetime :data_ate
      t.datetime :data_enc

      t.timestamps
    end
  end

  def self.down
    drop_table :manutencaos
  end
end
