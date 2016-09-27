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

  scope :find_tacos_by_ids, -> (ids) { joins(:tacos).where(tacos: {id: ids}) }
  scope :find_salsas_by_ids, -> (ids) { joins(:salsas).where(salsas: {id: ids}) }
  scope :group_results, -> (count) { group(:id).having('count(*) >= ?', count) }
end