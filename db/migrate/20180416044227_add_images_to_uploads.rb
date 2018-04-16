class AddImagesToUploads < ActiveRecord::Migration[5.2]
  def change
    add_column :uploads, :images, :string
  end
end
