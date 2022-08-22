class Company < ApplicationRecord
  has_many :employees
  has_many :set_ups
end
