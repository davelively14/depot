require 'test_helper'

class UserStoriesTest < ActionDispatch::IntegrationTest
  fixtures :products

  # USER STORY: Buying a Product
  # A user goes to the index page. They select a product, adding it to their
  # cart, and check out, filling in their details on the checkout form. When
  # they submit, an order is created containing their information, along with a
  # single line item corresponding to the product they added to their cart.
  test "buying a product" do

    # By the end of the test, we know we'll want to have added an order to the orders table and a line item to the
    # line_items table, so we'll empty them out here.
    LineItem.delete_all
    Order.delete_all

    # Load the Ruby book fixture data into a local variable, ruby_book
    ruby_book = products(:ruby)

    # STORY: A user goes to the store index page
    # '/' is the default page, in this case index
    get "/"
    assert_response :success
    assert_template "index"

    # STORY: They select a product, adding it to their cart
    # We know that our application uses an Ajax request to add things to the cart, so we'll use xml_http_request().
    xml_http_request :post, '/line_items', product_id: ruby_book.id
    assert_response :success

    # When it returns, we'll check that the cart now contains the requested product.
    cart = Cart.find(session[:cart_id])
    assert_equal 1, cart.line_items.size
    assert_equal ruby_book, cart.line_items[0].product

    # STORY: They then check out
    get "/orders/new"
    assert_response :success
    assert_template "new"

    # STORY: They fill in their details on the checkout form and submit.
    # Verify the post-redirect to the index page and cart is empty.
    post_via_redirect "/orders",
                      order: {  name:       "Dave Thomas",
                                address:    "123 The Street",
                                email:      "dave@example.com",
                                pay_type:   "Check" }
    assert_response :success
    assert_template "index"
    cart = Cart.find(session[:cart_id])
    assert_equal 0, cart.line_items.size

    # STORY: an order is created containing their information, along with a single line item corresponding to the
    # product they added to their cart.
    orders = Order.all
    assert_equal 1, orders.size
    order = orders[0]

    assert_equal "Dave Thomas",       order.name
    assert_equal "123 The Street",    order.address
    assert_equal "dave@example.com",  order.email
    assert_equal "Check",             order.pay_type

    assert_equal 1, order.line_items.size
    line_item = order.line_items[0]
    assert_equal ruby_book, line_item.product

    # STORY: User receives a confirmation email of the order.
    mail = ActionMailer::Base.deliveries.last
    assert_equal ["dave@example.com"], mail.to
    assert_equal 'Nile Trading Co <info@niletradingco.com>', mail[:from].value
    assert_equal 'Pragmatic Store Order Confirmation', mail.subject
  end

end
