# This template can use generic XML functionality that Builder provides as well as using the knowledge of the Atom feed
# format that the atom_feed helper provides.  The products_controller.rb set this format in the who_bought method.
#
# This template is meant to feed who ordered a particular product
#
# Note: More information can be found in the Builder can be found in Section 24.1, Generating XML with Builder, on page
# 393.
atom_feed do |feed|

  # Sets title of the atom_feed to 'Who bought <product title of last purchased title>'
  feed.title "Who bought #{@product.title}"

  feed.updated @latest_order.try(:updated_at)

  @product.orders.each do |order|
    feed.entry(order) do |entry|
      entry.title "Order #{order.id}"
      entry.summary type: 'xhtml' do |xhtml|
        xhtml.p "Shipped to #{order.address}"
        xhtml.table do
          xhtml.tr do
            xhtml.th 'Product'
            xhtml.th 'Quantity'
            xhtml.th 'Total Price'
          end
          order.line_items.each do |item|
            xhtml.tr do
              xhtml.td item.product.title
              xhtml.td item.quantity
              xhtml.td number_to_currency item.total_price
            end
          end
          xhtml.tr do
            xhtml.th 'total', colspan: 2
            xhtml.th number_to_currency order.line_items.map(&:total_price).sum
          end
        end
        xhtml.p "Paid by #{order.pay_type}"
      end
      entry.author do |author|
        author.name order.name
        author.email order.email
      end
    end
  end
end