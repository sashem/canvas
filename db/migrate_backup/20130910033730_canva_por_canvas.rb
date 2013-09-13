class CanvaPorCanvas < ActiveRecord::Migration
  def change
    rename_column :actividades, :canvas_id, :canva_id
    rename_column :recursos, :canvas_id, :canva_id
    rename_column :canales, :canvas_id, :canva_id
    rename_column :relaciones, :canvas_id, :canva_id
    rename_column :segmentos, :canvas_id, :canva_id
    rename_column :socios, :canvas_id, :canva_id
    rename_column :costos, :canvas_id, :canva_id
    rename_column :ingresos, :canvas_id, :canva_id
  end
end
