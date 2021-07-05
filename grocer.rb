def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  n = 0
  while n < collection.length do
    if collection[n][:item] == name
      return collection[n]
    end
    n += 1
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  n_c = [] #new cart
  n = 0
  while n < cart.length do
    n_c_i = find_item_by_name_in_collection(cart[n][:item], n_c) #new cart item
    if n_c_i != nil
      n_c_i[:count] += 1
    else
      n_c_i = {
        :item => cart[n][:item],
        :price => cart[n][:price],
        :clearance => cart[n][:clearance],
        :count => 1
      }
      n_c.append(n_c_i) #To add items to the new cart.
    end
    n += 1
  end
  return n_c
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  result = []
  if coupons.length == 0
    return cart
  end
  count = 0
  while count < cart.length do
    cart_item = cart[count]
    coupon_item = find_item_by_name_in_collection(cart_item[:item], coupons)
    if coupon_item
      n_c_c = cart_item[:count] % coupon_item[:num] #no coupon count
      # c_a_c = cart_item[:count] - n_c_c   # coupon applied count
      p_u_p = coupon_item[:cost] / coupon_item[:num]  #per unit price
      #c_i_c = c_a_c / coupon_item[:num] #coupon items count
      t_h = {
        :item => "#{cart_item[:item]} W/COUPON",
        :price => p_u_p,
        :clearance => cart_item[:clearance],
        :count => coupon_item[:num]
      } #temporary hash
      result.append(t_h)
      cart_item[:count] = n_c_c
    end
    result.append(cart_item)
    count += 1
  end
  return result
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  n = 0
  while n < cart.length do
    if cart[n][:clearance]
      cart[n][:price] *= 0.8
    end
    n += 1
  end
  return cart
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
  coupons_applied_cart = apply_coupons(consolidated_cart, coupons)
  clearance_applied_cart = apply_clearance(coupons_applied_cart)
  total = 0
  n = 0
  while n < clearance_applied_cart.length do
    total += (clearance_applied_cart[n][:count] * clearance_applied_cart[n][:price])
    n += 1
  end
  if total > 100
    total *= 0.9
  end
  return total.round(2)
end
