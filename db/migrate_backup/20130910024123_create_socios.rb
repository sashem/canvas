class CreateSocios < ActiveRecord::Migration
  def change
    create_table :socios do |t|
      t.string :abreviacion
      t.string :descripcion
      t.string :color
      t.integer :canvas_id

      t.timestamps
    end
  end
end
