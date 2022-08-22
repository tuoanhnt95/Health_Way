class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :admin, :boolean
    add_reference :users, :company, null: false, foreign_key: true
    add_column :users, :fax_extension, :integer
  end
end
