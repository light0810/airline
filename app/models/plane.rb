class Plane < ActiveRecord::Base
  belongs_to :company
  has_many :flights
  has_many :tickets
  has_many :carts

  validates :code, presence: true, length: {maximum: 20}
  validates :name, presence: true, length: {maximum: 20}

  enum status: [:not_ready, :ready]
end
