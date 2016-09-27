class Taco < ActiveRecord::Base
  has_many :stores_tacos
  has_many :stores, through: :stores_tacos

  validates  :name,
              presence: true,
              length: { maximum: 255 }

  validates :vegetarian,
              inclusion: { in: [true, false] }
end