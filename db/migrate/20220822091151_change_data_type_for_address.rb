class ChangeDataTypeForAddress < ActiveRecord::Migration[7.0]
  def change
    change_column :clinics, :address, :string
  end
end
