module CurrentCart #accessible to all controllers
  extend ActiveSupport::Concern

  private

  # This will be used to align the user's session with the user's cart using cookies.
  def set_cart

    # Sets the @cart to the cart associated with the session.
    @cart = Cart.find(session[:cart_id])

  # If this method returns a "RecordNotFound" error, this section will fire and create a car and set a cart_id
  # attribute for the session, to the newly created cart.id.
  rescue ActiveRecord::RecordNotFound
    @cart = Cart.create
    session[:cart_id] = @cart.id
  end
end