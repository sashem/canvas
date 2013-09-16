class CanvaexpressSerializer < ActiveModel::Serializer
    attributes :id, :nombre, :descripcion, :editable
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
