class Order < ActiveRecord::Base
  # Each Order will have many Line_Items. If a line_items is destroyed, the order will be destroyed, too.
  has_many :line_items, dependent: :destroy

  PAYMENT_TYPES = [ "Check", "Credit Card", "Purchase Order" ]

  # Ensures values exist for name, address and email. Note that email is not validated to be in a proper format.
  validates :name, :address, :email, presence: true

  # Ensures that the value for pay_type is included within PAYMENT_TYPES. Even though it's a drop down menu, there is
  # no guarantee a user will utilize the provided HTML form to enter the information. As a result, a malicious user
  # could bypass payment terms and perceivably get items for free.
  validates :pay_type, inclusion: PAYMENT_TYPES

  # For each item that we transfer from the cart to that order, we need to set the cart_id to nil in order prevent the
  # item from being destroyed when we destroy the cart. Then, we add the item itself to the line_items collection,
  # which will be returned and function as the collection for the order.
  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
