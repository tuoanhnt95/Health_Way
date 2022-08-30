class SetUp < ApplicationRecord
  belongs_to :company
  has_many :health_checks, dependent: :destroy
  has_many :clinic_set_ups, dependent: :destroy
  has_many :clinics, through: :clinic_set_ups
  has_many :users, through: :health_checks
  has_noticed_notifications

  validates :start_date, presence: true
  validates :end_date, presence: true
end
