class CreateInscricaos < ActiveRecord::Migration
  def self.up
    create_table :inscricaos do |t|
      t.references :participante, :null => false
      t.date :data_inscricao
      t.interger :opcao1
      t.interger:opcao2
      t.string:periodoop1
      t.string:periodoop2
      t.boolean :status, :default => 1
      t.boolean :encerrado, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :inscricaos
  end
end
