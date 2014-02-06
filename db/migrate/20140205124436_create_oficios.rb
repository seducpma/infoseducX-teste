class CreateOficios < ActiveRecord::Migration
  def self.up
    create_table :oficios do |t|
      t.string :emissor
      t.string :assunto
      t.string :destinatario
      t.datetime :data
      t.string :obs

      t.timestamps
    end
  end

  def self.down
    drop_table :oficios
  end
end
