# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_190_903_031_952) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'comments', force: :cascade do |t|
    t.text 'content'
    t.bigint 'post_id'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[post_id created_at], name: 'index_comments_on_post_id_and_created_at'
    t.index ['post_id'], name: 'index_comments_on_post_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'friendships', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'friend_id'
    t.boolean 'confirmed', default: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index 'GREATEST(user_id, friend_id), LEAST(user_id, friend_id)', name: 'index_friendships_on_interchangable_user_id_and_friend_id', unique: true
    t.index 'LEAST(user_id, friend_id), LEAST(user_id, friend_id)', name: 'index_friendships_on_interchangable_friend_id_and_user_id', unique: true
    t.index ['friend_id'], name: 'index_friendships_on_friend_id'
    t.index ['user_id'], name: 'index_friendships_on_user_id'
  end

  create_table 'post_like_brokers', force: :cascade do |t|
    t.bigint 'user_id'
    t.bigint 'post_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[post_id created_at], name: 'index_post_like_brokers_on_post_id_and_created_at'
    t.index %w[post_id user_id], name: 'index_post_like_brokers_on_post_id_and_user_id', unique: true
    t.index ['post_id'], name: 'index_post_like_brokers_on_post_id'
    t.index %w[user_id created_at], name: 'index_post_like_brokers_on_user_id_and_created_at'
    t.index ['user_id'], name: 'index_post_like_brokers_on_user_id'
  end

  create_table 'posts', force: :cascade do |t|
    t.text 'content'
    t.bigint 'author_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index %w[author_id created_at], name: 'index_posts_on_author_id_and_created_at'
    t.index ['author_id'], name: 'index_posts_on_author_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'provider'
    t.string 'uid'
    t.string 'first_name'
    t.string 'last_name'
    t.string 'profile_pic'
    t.string 'provider_token'
    t.string 'provider_secret'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'comments', 'posts'
  add_foreign_key 'comments', 'users'
  add_foreign_key 'friendships', 'users'
  add_foreign_key 'friendships', 'users', column: 'friend_id'
  add_foreign_key 'post_like_brokers', 'posts'
  add_foreign_key 'post_like_brokers', 'users'
end
