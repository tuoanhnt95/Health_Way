class HealthCheck < ApplicationRecord
  belongs_to :set_up
  belongs_to :user
  belongs_to :clinic

  has_one_attached :result
end
