class Ticket < ActiveRecord::Base
  belongs_to :plane
  belongs_to :flight
  belongs_to :user
  belongs_to :cart

  scope :get_by_status, ->(status){where "status = ?", status}
  scope :get_by_level, ->(level){where "level = ?", level}

  validates :location, presence: true, length: {maximum: 20}

  enum level: [:other, :type1, :type2, :type3]
  enum status: [:block, :sale, :own]
end
