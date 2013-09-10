class CreateRelaciones < ActiveRecord::Migration
  def change
    create_table :relaciones do |t|
      t.string :abreviacion
      t.string :descripcion
      t.string :color
      t.integer :canvas_id

      t.timestamps
    end
  end
end
