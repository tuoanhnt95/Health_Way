class SetUp < ApplicationRecord
  belongs_to :company
  has_many :health_checks
  has_many :clinic_set_ups
  has_many :users, through: :health_checks

  validates :start_date, presence: true
  validates :end_date, presence: true
end
