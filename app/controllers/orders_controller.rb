class OrdersController < ApplicationController
  # Our module inside the controllers/concerns director.  Allows us to align the cart and the session.
  include CurrentCart

  # When the new and create functions are called, the set_cart method (CurrentCart) will intercept and run first. In
  # this case, it will ensure the cart exists and is aligned with the session_id.
  before_action :set_cart, only: [:new, :create]
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
  end

  # GET /orders/new
  def new

    # Ensures that the user cannot create an empty order. If the cart is empty, the user will be redirected to the
    # store with a notice.  NOTE: you must include the return statement here or else the system will continue and
    # result in a "double render error" because your controller will attempt to both redirect and render output.
    if @cart.line_items.empty?
      redirect_to store_url, notice: "Your cart is empty"
      return
    end

    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    # Creates a new Order object and passes the data from the from as parameters.
    @order = Order.new(order_params)

    # This is a method that will be created. FINISH THIS.
    @order.add_line_items_from_cart(@cart)

    respond_to do |format|
      if @order.save
        # Empty the cart and destroy the cart_id after order is finalized to prevent duplicate orders.
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil

        # Once order complete, redirect to the store front with a thank you notice.
        format.html { redirect_to store_url, notice: 'Thank you for your order.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type)
    end
end
