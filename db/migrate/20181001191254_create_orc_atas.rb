class CreateOrcAtas < ActiveRecord::Migration
  def self.up
    create_table :orc_atas do |t|
      t.string :codigo
      t.string :modalidade
      t.string :administrativo
      t.string :objetivo
      t.string :interessado
      t.string :cnpj
      t.string :ie
      t.string :endereco
      t.string :cidade
      t.string :estado
      t.string :cep
      t.string :fone
      t.string :e_mail
      t.string :contato
      t.date :data
      t.decimal :total_total
      t.string :obs

      t.timestamps
    end
  end

  def self.down
    drop_table :orc_atas
  end
end
