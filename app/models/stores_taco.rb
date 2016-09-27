class StoresTaco < ActiveRecord::Base
  belongs_to :store
  belongs_to :taco

  validates :store_id,
              presence: true

  validates :taco_id,
              presence: true

  validates :price,
              presence: true,
              numericality: :true,
              :format => { :with => /\A\d+(?:\.\d{0,2})?\z/ }
end
