class CreateAcompanhamentos < ActiveRecord::Migration
  def self.up
    create_table :acompanhamentos do |t|
      t.string :crianca
      t.string :mae
      t.string :responsavel
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
      t.string :assunto
      t.integer :encerrado
      t.string :obs

      t.timestamps
    end
  end

  def self.down
    drop_table :acompanhamentos
  end
end
