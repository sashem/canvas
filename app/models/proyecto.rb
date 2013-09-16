class Proyecto < ActiveRecord::Base
  belongs_to :user
  has_many :canvas
  has_many :permisos, :dependent => :destroy
end
