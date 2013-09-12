class Mensaje < ActiveRecord::Base
  belongs_to :canva
  belongs_to :user
end
