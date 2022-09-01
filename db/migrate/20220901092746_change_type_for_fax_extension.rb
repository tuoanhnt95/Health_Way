class ChangeTypeForFaxExtension < ActiveRecord::Migration[7.0]
  def change
    change_column :users, :fax_extension, :string
  end
end
