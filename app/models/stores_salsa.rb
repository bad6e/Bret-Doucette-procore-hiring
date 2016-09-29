class StoresSalsa < ActiveRecord::Base
  belongs_to :store
  belongs_to :salsa

  validates :store_id,
              presence: true

  validates :salsa_id,
              presence: true,
              uniqueness: { scope: :store_id }

  validates :spiciness,
              presence: true,
              numericality: { only_integer: true }
end
