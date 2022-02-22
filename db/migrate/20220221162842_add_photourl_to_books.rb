class AddPhotourlToBooks < ActiveRecord::Migration[6.1]
  def change
    add_column :books, :photo_url, :string
  end
end
