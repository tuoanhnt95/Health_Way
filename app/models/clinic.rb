class Clinic < ApplicationRecord
  has_many :clinic_set_ups
  has_many :health_checks
  has_many :users, through: :health_checks
end
