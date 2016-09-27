class StoresSalsa < ActiveRecord::Base
  belongs_to :store
  belongs_to :salsa

  validates :store_id,
              presence: true

  validates :salsa_id,
              presence: true

  validates :spiciness,
              presence: true,
              numericality: { only_integer: true }
end
