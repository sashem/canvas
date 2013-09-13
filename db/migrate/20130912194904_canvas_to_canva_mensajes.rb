class CanvasToCanvaMensajes < ActiveRecord::Migration
  def change
    rename_column :mensajes, :canvas_id, :canva_id
  end
end
