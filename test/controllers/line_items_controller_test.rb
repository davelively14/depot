require 'test_helper'

class LineItemsControllerTest < ActionController::TestCase
  setup do
    @line_item = line_items(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:line_items)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create line_item" do
    assert_difference('LineItem.count') do
      post :create, product_id: products(:ruby).id
    end

    assert_redirected_to store_path
  end

  test "should show line_item" do
    get :show, id: @line_item
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @line_item
    assert_response :success
  end

  test "should update line_item" do
    patch :update, id: @line_item, line_item: { product_id: @line_item.product_id }
    assert_redirected_to line_item_path(assigns(:line_item))
  end

  test "should destroy line_item" do
    assert_difference('LineItem.count', -1) do
      delete :destroy, id: @line_item
    end

    assert_redirected_to line_items_path
  end

  # Similar to the "should create line_item" test above, this ensures functionality of a create line_item, but with
  # ajax considerations. Instead of a redirect, we expect a successful response containing a call to replace the HTML
  # for the cart, and in that HTML we expect to find a row with an ID of current_item with a value matching Programming
  # Ruby 1.9.  This is achieved by applying the assert_select_jquery() to extract the relevant HTML and then processing
  # that HTML via whatever additional assertions you want to apply.
  test "should create line_item via ajax" do

    # Evaluated when LineItem.count changes (i.e. a LineItem was created)
    assert_difference('LineItem.count') do

      # xhr stands for XML-HttpRequest).
      xhr :post, :create, product_id: products(:ruby).id
    end

    assert_response :success
    assert_select_jquery :html, '#cart' do
      assert_select 'tr#current_item td', /Programming Ruby 1.9/
    end

  end
end
