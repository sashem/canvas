class CambioPermisosAProyectos < ActiveRecord::Migration
  def change
    rename_column :permisos, :canva_id, :proyecto_id
  end
end
