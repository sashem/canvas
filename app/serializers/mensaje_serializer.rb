class MensajeSerializer < ActiveModel::Serializer
  attributes :id,:contenido, :username
  def username
    object.user.username
  end
end
