module ApplicationHelper

  # This helper will return block of html code with certain attributes.  One attribute to be added would be "display:
  # none" if the passed condition is true (in this case, if the cart is empty).
  def hidden_dev_if(condition, attributes = {}, &block)
    if condition
      attributes["style"] = "display: none"
    end

    # Rails standard helper content_tag() can be used to wrap the output created by a block in a specific tag. In this
    # case, content_tag() will wrap the passed block in a "div" tag.
    content_tag("div", attributes, &block)
  end
end
