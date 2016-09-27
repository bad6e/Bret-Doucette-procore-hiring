class City < ActiveRecord::Base
  has_many :stores

  validates :name,
              presence: true,
              length: { maximum: 255 }

  validates :allows_drones,
              inclusion: { in: [true, false] }
end