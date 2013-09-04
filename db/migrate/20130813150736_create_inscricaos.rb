class CreateInscricaos < ActiveRecord::Migration
  def self.up
    create_table :inscricaos do |t|
      t.references :participante, :null => false
      t.date :data_inscricao
      t.status :boolean, :default => 0
      t.opcao1 :interger
      t.opcao2 :integer
      t.periodoop1 :string
      t.periodoop2 :string
      t.timestamps
    end
  end

  def self.down
    drop_table :inscricaos
  end
end
