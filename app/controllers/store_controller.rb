class StoreController < ApplicationController
  # Whitelist store controller from admin authorization
  skip_before_action :authorize

  include CurrentCart
  before_action :set_cart

  def index

    # Will redirect to the store path for a given locale if the :set_locale form is used.
    if params[:set_locale]
      redirect_to store_url(locale: params[:set_locale])
    else
      @products = Product.order(:title)
    end
  end
end
