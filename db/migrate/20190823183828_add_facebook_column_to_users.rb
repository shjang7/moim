# frozen_string_literal: true

class AddFacebookColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider,     :string
    add_column :users, :uid,          :string
    add_column :users, :name,         :string
    add_column :users, :first_name,   :string
    add_column :users, :last_name,    :string
    add_column :users, :profile_pic,  :text
    add_column :users, :token,        :string
    add_column :users, :secret,       :string
  end
end
