class CreateMensajes < ActiveRecord::Migration
  def change
    create_table :mensajes do |t|
      t.string :contenido
      t.integer :user_id
      t.integer :canvas_id

      t.timestamps
    end
  end
end
