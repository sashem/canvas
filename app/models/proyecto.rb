class Proyecto < ActiveRecord::Base
  belongs_to :user
  has_many :canvas
end
