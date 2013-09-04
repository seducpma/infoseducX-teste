class CreateParticipantes < ActiveRecord::Migration
  def self.up
    create_table :participantes do |t|
      t.string :nome
      t.string :matricula
      t.references :unidade
      t.string :funcao
      t.string :profissao
      t.string :endereco
      t.string :num
      t.string :complemento
      t.string :bairro
      t.string :cidade
      t.string :CEP
      t.string :telefone
      t.string :cel
      t.string :email
      t.string :rg
      t.string :cpf
      t.string :obs

      t.timestamps
    end
  end

  def self.down
    drop_table :participantes
  end
end
