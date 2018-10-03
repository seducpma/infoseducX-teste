class CreateOrcAtaItens < ActiveRecord::Migration
  def self.up
    create_table :orc_ata_itens do |t|
      t.references :orc_ata
      t.decimal :quantidade
      t.string :descricao
      t.decimal :unitario
      t.decimal :total
      t.decimal :total_geral
      t.string :obs

      t.timestamps
    end
  end

  def self.down
    drop_table :orc_ata_itens
  end
end
