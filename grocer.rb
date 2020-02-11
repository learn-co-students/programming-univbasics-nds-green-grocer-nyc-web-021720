
def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i = 0 
  while i < collection.length do 
  return collection[i] if name == collection[i][:item]
  i += 1
  end
  nil 
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  result = []
  i = 0 
  while i < cart.length do 
    name = cart[i][:item]
    found_item = find_item_by_name_in_collection(name, result)
    if found_item
      found_item[:count] += 1
    else 
      cart[i][:count] = 1 
      result << cart[i]
    end 
    i += 1
  end 
  result
end


def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
    i = 0 
  while i < coupons.length do 
    coupon_name =coupons[i][:item]
    cart_item = find_item_by_name_in_collection(coupon_name, cart)
    coupon_label = "#{coupons[i][:item]} W/COUPON"
    couponed_item = find_item_by_name_in_collection(coupon_label, cart)
    if cart_item && cart_item[:count] >= coupons[i][:num]
      if couponed_item
        couponed_item[:count] += coupons[i][:num]
        cart_item[:count] -= coupons[i][:num]
      else 
        couponed_item = {
          item: coupon_label,
          price: coupons[i][:cost] / coupons[i][:num],
          count: coupons[i][:num],
          clearance: cart_item[:clearance]
        }
        cart_item[:count] -= coupons[i][:num]
        cart << couponed_item
      end
    end
  i += 1 
  end 
  cart 
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i = 0 
  while i < cart.length do 
    cart_header = cart[i]
  if cart_header[:clearance]
    cart_header[:price] = (cart_header[:price]-(cart_header[:price].to_f) * 0.20).round(2)
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
  full_cart = consolidate_cart(cart)
  cart_after_coupons = apply_coupons(full_cart, coupons)
  final_cart = apply_clearance(cart_after_coupons)
  total = 0 
  i = 0 
  while i < final_cart.length do 
    total += final_cart[i][:price] * final_cart[i][:count]
    i += 1 
  end 
    if total > 100 
      total -= (total * 0.10)
    end 
    total 
end
