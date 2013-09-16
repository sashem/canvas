class CanvaSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :descripcion, :editable
  has_many :propuestas, key: :propuestas_attributes
  has_many :recursos, key: :recursos_attributes
  has_many :actividades, key: :actividades_attributes
  has_many :canales, key: :canales_attributes
  has_many :relaciones, key: :relaciones_attributes
  has_many :segmentos, key: :segmentos_attributes
  has_many :socios, key: :socios_attributes
  has_many :costos, key: :costos_attributes
  has_many :ingresos, key: :ingresos_attributes
  has_many :mensajes, key: :mensajes
  
  def editable
    if(object.proyecto.permisos.where(:user_id=>current_user.id).exists?)
      if(object.proyecto.permisos.find_by(:user_id=>current_user.id).valor>=2)
        return false
      else
        return true  
      end
      
      else
        if(object.proyecto.user_id==current_user.id)
          return true
        else
          return false
        end
    end
  end
end
