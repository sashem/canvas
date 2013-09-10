class CanvaSerializer < ActiveModel::Serializer
  attributes :id, :nombre, :descripcion
  has_many :propuestas, key: :propuestas_attributes
  has_many :recursos, key: :recursos_attributes
  has_many :actividades, key: :actividades_attributes
  has_many :canales, key: :canales_attributes
  has_many :relaciones, key: :relaciones_attributes
  has_many :segmentos, key: :segmentos_attributes
  has_many :socios, key: :socios_attributes
  has_many :costos, key: :costos_attributes
  has_many :ingresos, key: :ingresos_attributes
end
