class CreatePodaGramas < ActiveRecord::Migration
  def self.up
    create_table :poda_gramas do |t|
      t.references :unidade
      t.string :solicitante
      t.datetime :solicitacao
      t.date :agendamento
      t.date :realizacao
      t.string :realizad
      t.string :obs

      t.timestamps
    end
  end

  def self.down
    drop_table :poda_gramas
  end
end
