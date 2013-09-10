class CreatePropuesta < ActiveRecord::Migration
  def change
    create_table :propuesta do |t|
      t.string :abreviacion
      t.string :descripcion
      t.string :color
      t.integer :canva_id

      t.timestamps
    end
  end
end
