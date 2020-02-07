def find_item_by_name_in_collection(name, collection)
# INPUTS:
#   name: a STRING of the 'name of the item to find'
#   collection: an ARRAY of items to search through
  i = 0
  while i < collection.count do
    if collection[i][:item] == name
      return collection[i]
    end
    i += 1
  end
  # RETURN:
  #   nil: if no match is found
  #   the matching HASH if a match is found between the desired name and a given HASH's :item key
end

def consolidate_cart(cart)
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.

  consolidated_cart = []
  i = 0
  while i < cart.count do  ## - I might start leaving out the 'do's
    consolidated_cart_product = find_item_by_name_in_collection(cart[i][:item], consolidated_cart)

    if consolidated_cart_product  # could say: if consolidated_cart_product != nil
      consolidated_cart_product[:count] += 1
    else
      consolidated_cart_product = {
        :item => cart[i][:item],
        :price => cart[i][:price],
        :clearance => cart[i][:clearance],
        :count => 1
      }
      consolidated_cart << consolidated_cart_product
    end

    i += 1
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)

  # Using the logic and variables from the video walkthrough now,
  # except using 'i' for the counter
  # (my original attempt got too convoluted - starting over)
  i = 0
  while i < coupons.length
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
    couponed_item_name = "#{coupons[i][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if cart_item && cart_item[:count] >= coupons[i][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[i][:num]
        cart_item[:count] -= coupons[counter][:num]
      else
        cart_item_with_coupon = {
          :item => couponed_item_name,
          :price => coupons[i][:cost] / coupons[i][:num],
          :count => coupons[i][:num],
          :clearance => cart_item[:clearance]
        }
        cart << cart_item_with_coupon
        cart_item[:count] -= coupons[i][:num]
      end
    end
    i += 1
  end
  cart
end

def apply_clearance(cart)
  i = 0
  while i < cart.length
    if cart[i][:clearance]
      cart[i][:price] = (cart[i][:price] - (cart[i][:price] * 0.20)).round(2)
      # could also use: (cart[i][:price] * 0.80)
    end
    i += 1
  end
  cart
end

def checkout(cart, coupons)
  # Consult README for inputs and outputs
  #
  # This method should call
  # * consolidate_cart
  # * apply_coupons
  # * apply_clearance
  #
  # BEFORE it begins the work of calculating the total (or else you might have
  # some irritated customers

  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)
  final_cart = clearanced_cart # Renamed for clarity

  total = 0
  i = 0
  while i < final_cart.length
    total += final_cart[i][:price] * final_cart[i][:count]
    i += 1
  end

  if total > 100
    total -= (total * 0.10)  # Same as: total = total * 0.90
  end
  total
end


########################################################################
########################################################################
#         SCRATCH CODE
#
#  Possibly come back and add comments saying
#  which blocks of code solve which erros? (as per the video)

=begin

Personal notes:
This was my original attempt at the consolidate_cart method.
I had to check the video to get it right -
- I didn't think to use the find_item_by_name_in_collection,
I just started looping again (the loop with the 'k' iterator is unfinished:
but various attempts did not work, usually causing the :count to always equal '1')
I also tried a different tactic to 'remake' the hash:
  My strategy was to create an array of unique hashes first,
  each with a :count key equal to '1', then iterate through
  the cart again, incrementing each ':count' if the hash was
  already contained in the array.
There may have been a way to make this work, but I switched to the logic
in the video (kept my variables) to keep it simple and make sure I was
practicing coding it in a cleaner way.


def consolidate_cart(cart)
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.

  consolidated_cart = []
  i = 0
  while i < cart.count do  ## - I might start leaving out the 'do's
    # Creates an array of hashes with no duplicates
    # and a count of '1' for each hash
    if consolidated_cart.include?(cart[i][:item]) == false
      cart[i][:count] = 1
      consolidated_cart << (cart[i])
    end

    #####
    k = 0
    while k <

      if consolidated_cart.include?(cart[i][:item])
        consolidated_cart[i][:count] += 1
      end

    #####

    i += 1
  end

  consolidated_cart
end

##################################################################

=end
