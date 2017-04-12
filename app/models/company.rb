class Company < ActiveRecord::Base
  has_many :planes

  validates :name, presence: true, length: {maximum: 20}
end
