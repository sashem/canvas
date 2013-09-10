#encoding: utf-8
class CanvasController < ApplicationController
  before_action :set_canva, only: [:delete, :update_canva, :fetch_canva, :save, :add_item, :remove_item]
  before_filter :check_session, except: [:canvas]
  before_action :check_owner, only: [:delete, :update_canva, :fetch_canva, :save, :add_item, :remove_item]
  
  def canvas
    render file: "public/canvas/index"
  end
  
  def fetch
    canvas=Canva.where(:proyecto_id=>params["proyecto_id"])
    respond_to do |format|
        format.html{ render json: {canvas:canvas}}
    end
  end
  def fetch_canva
    respond_to do |format|
        format.html{ render json: @canva}
    end
  end
  
  def save
    tipos=["propuestas","recursos","actividades","canales","relaciones","segmentos","socios","costos","ingresos"]
    tipos.each do |item|
      prop_ids=[]
      itemsids=@canva.send(item).pluck(:id);
      if (itemsids!=[] and canva_params[item+"_attributes"])
          itemsids=itemsids.to_a
          canva_params[item+"_attributes"].each do |subitem|
              prop_ids.push(subitem[:id])
          end
      end
      todelete=itemsids-prop_ids
      todelete.each do |id|
        @canva.send(item).delete(id)
      end
    end
    
    respond_to do |format|
      if @canva.update(canva_params)
        response={msge:{type: 'success', msg:"Canvas guardado satisfactoriamente"}}
        format.html { render json: response}
      else
        response={msge:{type: 'warning', msg:"Ocurrió un error en el servidor"}}
        format.html { render json: response }
      end
    end
  end
  
  def update_canva
    respond_to do |format|
      if @canva.update(canva_params)
        canvas=Canva.where(:proyecto_id=>@canva.proyecto_id)
        response={msge:{type: 'success', msg:"Canvas actualizado satisfactoriamente"},canvas:canvas}
        format.html { render json: response}
      else
        response={msge:{type: 'warning', msg:"Ocurrió un error en el servidor"}}
        format.html { render json: response }
      end
    end
  end

  def create
    @canva = Canva.new(canva_params)
    @canva.proyecto_id=params[:proyecto_id]
    respond_to do |format|
      if @canva.save
        response={msge:{type: 'success', msg:"Canvas creado satisfactoriamente"},canva:@canva}
        format.html { render json: response}
      else
        response={msge:{type: 'warning', msg:"Ocurrió un error en el servidor"}}
        format.html { render json: response }
      end
    end
  end

  def delete
    respond_to do |format|
      if @canva.destroy
        canvas=Canva.where(:proyecto_id=>@proyecto_id)
        response={msge:{type: 'success', msg:"Proyecto eliminado satisfactoriamente"},canvas:canvas}
        format.html { render json: response}
      else
        response={msge:{type: 'warning', msg:"Ocurrió un error en el servidor"}}
        format.html { render json: response }
      end
    end
  end

  def add_item
    respond_to do |format|
      p canva_params
      if @canva.update(canva_params)
        format.html { render json: @canva}
      end
    end
  end
  
  def remove_item
    seccion=params[:seccion].gsub("_attributes","")
    respond_to do |format|
      if params[:id_a_borrar]==-1
        if @canva.send(seccion).last.delete
          format.html { render json: @canva}
        end
      end
      if params[:id_a_borrar]!=-1 and @canva.send(seccion).delete(params[:id_a_borrar])
        format.html { render json: @canva}
      end
    end
  end

  def set_access_control_headers 
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
      headers['Access-Control-Max-Age'] = '6000'
      headers['Access-Control-Allow-Headers'] = '*,x-requested-with'
  end

  private
    def check_owner
        if @canva.proyecto.user_id!=params[:my_user_id__]
          response={msge:{type: 'warning', msg:"¡Estos no son sus canvas!"}}
          respond_to do |format|
            format.html{ render json: response }
          end
        end
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_canva
      @canva = Canva.find(params[:id])
      @proyecto_id=@canva.proyecto_id
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def canva_params
      params.require(:canva).permit(:id,:nombre,:descripcion,:proyecto_id,
        propuestas_attributes:[:id, :abreviacion, :descripcion, :color],
        recursos_attributes:[:id, :abreviacion, :descripcion, :color],
        actividades_attributes:[:id, :abreviacion, :descripcion, :color],
        clientes_attributes:[:id, :abreviacion, :descripcion, :color],
        segmentos_attributes:[:id, :abreviacion, :descripcion, :color],
        canales_attributes:[:id, :abreviacion, :descripcion, :color],
        relaciones_attributes:[:id, :abreviacion, :descripcion, :color],
        costos_attributes:[:id, :abreviacion, :descripcion, :color],
        ingresos_attributes:[:id, :abreviacion, :descripcion, :color])
    end
end
