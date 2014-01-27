class CreateCurriculos < ActiveRecord::Migration
  def self.up
    create_table :curriculos do |t|
      t.string :nome
      t.string :RG
      t.string :CPF
      t.datetime :nascimento
      t.string :endereco
      t.integer :num
      t.string :complemento
      t.string :cep
      t.string :bairro
      t.string :cidade
      t.string :fone
      t.string :cel
      t.string :email
      t.string :civil
      t.string :modalidade
      t.string :curso
      t.string :instituicao
      t.string :periodo
      t.string :semestre
      t.datefime :data_ingresso
      t.datetime :data_termino
      t.string :pergunta1
      t.string :pergunta2
      t.string :pergunta3
      t.string :obs
      t.string :aval
      t.string :status
      t.datetime :data_entrevista

      t.timestamps
    end
  end

  def self.down
    drop_table :curriculos
  end
end
