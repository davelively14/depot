# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# Defines a function that executes on page load.  The first line defines a function using the -> operator and passes it
# to a function on(), which associates this function with two events: ready and page:change.  Ready is fired if
# people navigate to your page from outside your site, and page:change is the event that Turbolinks fires if people
# navigate to your page from within your site.
$(document).on "ready, page:change", ->

#  This finds all images that are an immediate child of elements defined with class="entry", which themselves are
#  the decendents of the element class="store".  Rails will combine all JS into a single resource. For each image found
#  (which could be zero when run against other pages in our application), a function is defined that is associated
#  with the click event for that image.
  $('.store .entry > img').click ->

#    The final line here processes the click event. It takes the element in question, namely 'this', and finds the parent element
#    (which will be the div that specifies class="entry"). Within that element we find the submit buttone, and we
#    proceed to call it's click method.  In other words, this finds the corresponding "add to cart" button and clicks
#    it.
    $(this).parent().find(':submit').click()