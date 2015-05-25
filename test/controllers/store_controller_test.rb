require 'test_helper'

class StoreControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_select '#columns #side a', minimum: 4
    assert_select '#main .entry', 3
    assert_select 'h3', 'Programming Ruby 1.9'
    assert_select '.price', /\$[,\d]+\.\d\d/
  end

  test "markup needed for store.js.coffee is in place" do
    get :index

    # Confirms that there are 3 images in the store. All items are located in products.yml within the test\fixtures
    # folder.
    assert_select '.store .entry > img', 3

    # Confirms that there are three input type submits within the store.
    assert_select '.entry input[type=submit]', 3
  end

end
