class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def add_product(product_id)
    current_item = line_items.find_by(product_id: product_id)
    if current_item
      current_item.quantity += 1
    else
      current_item = line_items.build(product_id: product_id)
    end
    current_item
  end

  # Converts all line_items to an array, according to what's in the { }, which are the sums of prices for each
  # line_item, then sums them all up and returns.  Ultimately, this returns the sum of the prices for everything
  # in the cart.
  def total_price
    line_items.to_a.sum { |item| item.total_price }
  end
end