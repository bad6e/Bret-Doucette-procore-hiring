class CarWash < ActiveRecord::Base
  belongs_to :store

  validates :store_id,
              presence: true

  validates :hot_wax,
              inclusion: { in: [true, false] }

  validates :full_detail,
              inclusion: { in: [true, false] }
end