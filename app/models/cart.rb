class Cart < ActiveRecord::Base
  belongs_to :plane
  belongs_to :flight
  belongs_to :user
  has_many :tickets

  after_update :assign_ticket

  def paypal_url(return_path)
    values = {
      :business => 'airline-app1@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_path,
      :invoice => id,
      :notify_url => "http://7dd97ee8.ngrok.com/cart_infos"
    }

    tickets.each_with_index do |ticket, index|
      values.merge!({
        "amount_#{index+1}" => ticket.price,
        "item_name_#{index+1}" => ticket.location,
        "item_number_#{index+1}" => ticket.id,
        "quantity_#{index+1}" => 1
      })
    end

    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

  private
  def assign_ticket
    if status == "Completed"
      self.tickets.each do |ticket|
        ticket.update_attributes status: 2, user_id: user_id
      end
    end
  end
end
