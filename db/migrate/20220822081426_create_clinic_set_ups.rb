class CreateClinicSetUps < ActiveRecord::Migration[7.0]
  def change
    create_table :clinic_set_ups do |t|
      t.references :clinic, null: false, foreign_key: true
      t.references :set_up, null: false, foreign_key: true

      t.timestamps
    end
  end
end
