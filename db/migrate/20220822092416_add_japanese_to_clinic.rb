class AddJapaneseToClinic < ActiveRecord::Migration[7.0]
  def change
    add_column :clinics, :name_jpn, :string
    add_column :clinics, :address_jpn, :string
  end
end
