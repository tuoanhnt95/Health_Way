class ClinicSetUp < ApplicationRecord
  belongs_to :clinic
  belongs_to :set_up
  belongs_to :company, through: :set_ups
end
