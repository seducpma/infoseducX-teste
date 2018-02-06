class CreateCertificados < ActiveRecord::Migration
  def self.up
    create_table :certificados do |t|
      t.integer :inscricao
      t.string :obs

      t.timestamps
    end
  end

  def self.down
    drop_table :certificados
  end
end
