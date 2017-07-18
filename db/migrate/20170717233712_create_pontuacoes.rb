class CreatePontuacoes < ActiveRecord::Migration[5.0]
  def change
    create_table :pontuacoes do |t|
      t.references :usuario, foreign_key: true
      t.integer :pontos
      t.integer :fase

      t.timestamps
    end
  end
end
