class StoreController < ApplicationController
  # Whitelist store controller from admin authorization
  skip_before_action :authorize

  include CurrentCart
  before_action :set_cart

  def index
    @products = Product.order(:title)
  end
end
