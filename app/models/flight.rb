class Flight < ActiveRecord::Base
  after_create :create_ticket

  belongs_to :plane
  has_many :tickets
  has_many :carts

  belongs_to :start_place, class_name: Place.name, foreign_key: :start_place_id
  belongs_to :end_place, class_name: Place.name, foreign_key: :end_place_id

  validates :code, presence: true, length: {maximum: 20}

  scope :get_confirm, ->{where "status = 1"}

  enum status: [:not_confirm, :confirm, :arrive, :delay]

  private
  def create_ticket
    number_ticket_1.times do |n|
      self.tickets.create! location: "#{self.code}-H1-#{n}", level: 1,
        plane_id: self.plane.id, price: self.price_ticket_1
    end

    number_ticket_2.times do |n|
      self.tickets.create! location: "#{self.code}-H2-#{n}", level: 2,
        plane_id: self.plane.id, price: self.price_ticket_2
    end

    number_ticket_3.times do |n|
      self.tickets.create! location: "#{self.code}-H3-#{n}", level: 3,
        plane_id: self.plane.id, price: self.price_ticket_3
    end

    if number_ticket_other != 0
      number_ticket_other.times do |n|
        self.tickets.create! location: "#{self.code}-HK-#{n}",
          plane_id: self.plane.id, price: self.price_ticket_other
      end
    end
  end
end
