class CreateCursos < ActiveRecord::Migration
  def self.up
    create_table :cursos do |t|
      t.string :nome_curto
      t.string :nome
      t.string :ministrante
      t.string :carga_horaria
      t.text :ementa
      t.text  :obs
      t.datetime :data_hora
      t.integer :qtde
      t.integer :vagas_disponiveis
      t.boolean :status, :default => 0
      t.date :data_inicio
      t.date :data_fim
      t.timestamps
    end
  end

  def self.down
    drop_table :cursos
  end
end
