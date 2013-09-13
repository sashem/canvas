class CreateDatos < ActiveRecord::Migration
  def change
    create_table :datos do |t|
      t.string :nombre
      t.string :apellido
      t.string :mail
      t.integer :edad

      t.timestamps
    end
  end
end
