class Clinic < ApplicationRecord
  has_many :clinic_set_ups
  has_many :health_checks
  has_many :users, through: :health_checks

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
