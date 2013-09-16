class Permiso < ActiveRecord::Base
  belongs_to :user
  belongs_to :proyecto
end
