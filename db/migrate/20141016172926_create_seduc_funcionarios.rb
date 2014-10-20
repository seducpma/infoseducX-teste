class CreateSeducFuncionarios < ActiveRecord::Migration
  def self.up
    create_table :seduc_funcionarios do |t|
      t.integer :matricula
      t.string :nome
      t.string :apelido
      t.string :funcao
      t.references :unidade
      t.string :obs1
      t.string :situacao
      t.datetime :inicio
      t.string :obs2
      t.integer :votou

      t.timestamps
    end
  end

  def self.down
    drop_table :seduc_funcionarios
  end
end
