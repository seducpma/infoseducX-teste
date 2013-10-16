class CreateFuncionarios < ActiveRecord::Migration
  def self.up
    create_table :funcionarios do |t|
      t.references :chefia
      t.string :nome
      t.string :matricula
      t.string :setor
      t.string :atribuicao
      t.boolean :desligado, :default => 0
      t.string :obs

      t.timestamps
    end
  end

  def self.down
    drop_table :funcionarios
  end
end
