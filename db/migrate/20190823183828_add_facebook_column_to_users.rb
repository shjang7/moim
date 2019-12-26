class AddFacebookColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :provider,         :string
    add_column :users, :uid,              :string
    add_column :users, :first_name,       :string
    add_column :users, :last_name,        :string
    add_column :users, :profile_pic,      :string
    add_column :users, :provider_token,   :string
    add_column :users, :provider_secret,  :string
  end
end
