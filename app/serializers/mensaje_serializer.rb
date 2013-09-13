class MensajeSerializer < ActiveModel::Serializer
  attributes :contenido, :username
  def username
    object.user.username
  end
end
