class Company < ApplicationRecord
  has_many :users
  has_many :set_ups
  has_many :health_checks, through: :set_ups
  has_many :clinic_set_ups, through: :set_ups
end
