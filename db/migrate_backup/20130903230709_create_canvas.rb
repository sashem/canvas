class CreateCanvas < ActiveRecord::Migration
  def change
    create_table :canvas do |t|
      t.string :nombre
      t.string :descripcion
      t.integer :proyecto_id

      t.timestamps
    end
  end
end
