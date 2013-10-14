class CreateChefias < ActiveRecord::Migration
  def self.up
    create_table :chefias do |t|
      t.string :nome
      t.string :setor
      t.boolean :desligado, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :chefias
  end
end
