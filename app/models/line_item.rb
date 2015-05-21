class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart

  # Returns the total price of all line items
  def total_price
    product.price * quantity
  end
end
