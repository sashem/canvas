# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130916030109) do

  create_table "actividades", force: true do |t|
    t.string   "abreviacion"
    t.string   "descripcion"
    t.string   "color"
    t.integer  "canva_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "canales", force: true do |t|
    t.string   "abreviacion"
    t.string   "descripcion"
    t.string   "color"
    t.integer  "canva_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "canvas", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.integer  "proyecto_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "costos", force: true do |t|
    t.string   "abreviacion"
    t.string   "descripcion"
    t.string   "color"
    t.integer  "canva_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "datos", force: true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.string   "mail"
    t.integer  "edad"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "ingresos", force: true do |t|
    t.string   "abreviacion"
    t.string   "descripcion"
    t.string   "color"
    t.integer  "canva_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lists", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mensajes", force: true do |t|
    t.string   "contenido"
    t.integer  "user_id"
    t.integer  "canva_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notificaciones", force: true do |t|
    t.integer  "user_id"
    t.string   "contenido"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "permisos", force: true do |t|
    t.integer  "user_id"
    t.integer  "proyecto_id"
    t.integer  "valor"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "propuesta", force: true do |t|
    t.string   "abreviacion"
    t.string   "descripcion"
    t.string   "color"
    t.integer  "canva_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "propuestas", force: true do |t|
    t.string   "abreviacion"
    t.string   "descripcion"
    t.string   "color"
    t.integer  "canva_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "proyectos", force: true do |t|
    t.string   "nombre"
    t.string   "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "recursos", force: true do |t|
    t.string   "abreviacion"
    t.string   "descripcion"
    t.string   "color"
    t.integer  "canva_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relaciones", force: true do |t|
    t.string   "abreviacion"
    t.string   "descripcion"
    t.string   "color"
    t.integer  "canva_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "segmentos", force: true do |t|
    t.string   "abreviacion"
    t.string   "descripcion"
    t.string   "color"
    t.integer  "canva_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "socios", force: true do |t|
    t.string   "abreviacion"
    t.string   "descripcion"
    t.string   "color"
    t.integer  "canva_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tasks", force: true do |t|
    t.string   "name"
    t.boolean  "done"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "list_id"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "session_key"
  end

end
