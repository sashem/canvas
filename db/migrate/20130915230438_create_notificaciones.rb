class CreateNotificaciones < ActiveRecord::Migration
  def change
    create_table :notificaciones do |t|
      t.integer :user_id
      t.string :contenido

      t.timestamps
    end
  end
end
