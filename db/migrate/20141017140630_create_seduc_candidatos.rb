class CreateSeducCandidatos < ActiveRecord::Migration
  def self.up
    create_table :seduc_candidatos do |t|
      t.string :nome
      t.string :apelido
      t.integer :matricula
      t.string :funcao
      t.references :unidade
      t.integer :votos
      t.refences :seduc_funcionario

      t.timestamps
    end
  end

  def self.down
    drop_table :seduc_candidatos
  end
end
