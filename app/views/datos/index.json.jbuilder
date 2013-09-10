json.array!(@datos) do |dato|
  json.extract! dato, :nombre, :apellido, :mail, :edad
  json.url dato_url(dato, format: :json)
end