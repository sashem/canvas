class DatosController < ApplicationController
  before_action :set_dato, only: [:show, :edit, :update, :destroy]
  
  def index
    @datos = Dato.all
  end

  # GET /datos/1
  # GET /datos/1.json
  def show
  end

  # GET /datos/new
  def new
    @dato = Dato.new
  end

  # GET /datos/1/edit
  def edit
  end

  # POST /datos
  # POST /datos.json
  def create
    @dato = Dato.new(dato_params)

    respond_to do |format|
      if @dato.save
        format.html { redirect_to @dato, notice: 'Dato was successfully created.' }
        format.json { render action: 'show', status: :created, location: @dato }
      else
        format.html { render action: 'new' }
        format.json { render json: @dato.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /datos/1
  # PATCH/PUT /datos/1.json
  def update
    respond_to do |format|
      if @dato.update(dato_params)
        format.html { redirect_to @dato, notice: 'Dato was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @dato.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /datos/1
  # DELETE /datos/1.json
  def destroy
    @dato.destroy
    respond_to do |format|
      format.html { redirect_to datos_url }
      format.json { head :no_content }
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_dato
      @dato = Dato.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def dato_params
      params.require(:dato).permit(:nombre, :apellido, :mail, :edad)
    end
end
