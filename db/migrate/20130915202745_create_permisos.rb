class CreatePermisos < ActiveRecord::Migration
  def change
    create_table :permisos do |t|
      t.integer :user_id
      t.integer :canva_id
      t.integer :valor
      
      t.timestamps
    end
  end
end
