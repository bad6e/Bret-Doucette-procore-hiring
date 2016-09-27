class Store < ActiveRecord::Base
  has_one :car_wash

  belongs_to :city

  has_many :stores_tacos
  has_many :tacos, through: :stores_tacos

  has_many :stores_salsas
  has_many :salsas, through: :stores_salsas

  validates :name,
              presence: true,
              length: { maximum: 255 }

  validates :city_id,
              presence: true

  validates :sells_beer,
              inclusion: { in: [true, false] }

  validates :zagat_rating,
              presence: true,
              numericality: { only_integer: true }
end