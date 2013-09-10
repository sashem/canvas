class UserSerializer < ActiveModel::Serializer
  attributes :username
  has_one :dato, key: :dato_attributes
end
