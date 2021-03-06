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

ActiveRecord::Schema.define(version: 20_160_810_041_023) do
  create_table 'games', force: :cascade do |t|
    t.integer  'player1_id', null: false
    t.integer  'player2_id', null: false
    t.integer  'player3_id'
    t.integer  'player4_id'
    t.integer  'winner'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['player1_id'], name: 'index_games_on_player1_id'
    t.index ['player2_id'], name: 'index_games_on_player2_id'
    t.index ['player3_id'], name: 'index_games_on_player3_id'
    t.index ['player4_id'], name: 'index_games_on_player4_id'
  end

  create_table 'moves', force: :cascade do |t|
    t.integer  'game_id'
    t.integer  'ordinal'
    t.integer  'player'
    t.integer  'variety'
    t.integer  'x'
    t.integer  'y'
    t.datetime 'created_at',   null: false
    t.datetime 'updated_at',   null: false
    t.index ['game_id'], name: 'index_moves_on_game_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string   'username',        null: false
    t.string   'password_digest', null: false
    t.string   'email'
    t.datetime 'created_at',      null: false
    t.datetime 'updated_at',      null: false
  end
end
