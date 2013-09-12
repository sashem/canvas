class Canva < ActiveRecord::Base
  belongs_to :proyecto
  
  has_many :mensajes, :dependent => :destroy
  has_many :propuestas, :dependent => :destroy
  has_many :recursos, :dependent => :destroy
  has_many :actividades, :dependent => :destroy
  has_many :canales, :dependent => :destroy
  has_many :relaciones, :dependent => :destroy
  has_many :segmentos, :dependent => :destroy
  has_many :socios, :dependent => :destroy
  has_many :costos, :dependent => :destroy
  has_many :ingresos, :dependent => :destroy
  
  accepts_nested_attributes_for :propuestas,:recursos,:actividades,:canales,:relaciones,:segmentos,:socios,:costos,:ingresos, :mensajes

end
