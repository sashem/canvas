class User < ActiveRecord::Base
  has_one :dato, :dependent => :destroy
  has_many :proyectos, :dependent => :destroy
  has_many :mensajes
  accepts_nested_attributes_for :dato
  accepts_nested_attributes_for :proyectos
end
