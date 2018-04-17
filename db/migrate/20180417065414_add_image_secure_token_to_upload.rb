class AddImageSecureTokenToUpload < ActiveRecord::Migration[5.2]
  def change
    add_column :uploads, :image_secure_token, :string
  end
end
