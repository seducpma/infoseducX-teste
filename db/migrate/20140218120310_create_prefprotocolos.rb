class CreatePrefprotocolos < ActiveRecord::Migration
  def self.up
    create_table :prefprotocolos do |t|
      t.string :codigo
      t.datetime :data
      t.string :de
      t.string :assunto
      t.strig :para
      t.string :destino
      t.integer :encerrado, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :prefprotocolos
  end
end
