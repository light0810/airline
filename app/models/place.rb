class Place < ActiveRecord::Base
  has_many :start_flights, class_name: Flight.name, dependent: :destroy, foreign_key: :start_place_id
  has_many :end_flights, class_name: Flight.name, dependent: :destroy, foreign_key: :end_place_id

  validates :city, presence: true, length: {maximum: 20}
  validates :country, presence: true, length: {maximum: 20}
end
