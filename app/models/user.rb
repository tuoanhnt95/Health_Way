class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  belongs_to :company
  has_many :health_checks, dependent: :destroy
  has_one_attached :photo
  has_many :notifications, as: :recipient, dependent: :destroy
end
