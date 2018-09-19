class CreateOrcNotaFiscals < ActiveRecord::Migration
  def self.up
    create_table :orc_nota_fiscals do |t|
      t.references :orc_empenho
      t.decimal :valor
      t.date :data
      t.string :obs

      t.timestamps
    end
  end

  def self.down
    drop_table :orc_nota_fiscals
  end
end
