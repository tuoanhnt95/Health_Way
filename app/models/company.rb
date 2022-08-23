class Company < ApplicationRecord
  has_many :users
  has_many :health_checks, through: :users # company.healthchecks
  has_many :set_ups
end
