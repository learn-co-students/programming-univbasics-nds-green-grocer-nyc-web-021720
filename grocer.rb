def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0
  isFound = nil
  while index < collection.length do
    if collection[index][:item] == name
      isFound = collection[index]
    end
    index += 1
  end
  isFound
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  all_items = [] # unique array
  index = 0

  while index < cart.count do
    item = cart[index][:item]
    item_to_find = find_item_by_name_in_collection(item, all_items)
    if item_to_find
      item_to_find[:count] += 1
    else
      cart[index][:count] = 1
      all_items << cart[index]
    end
    index += 1
  end
all_items
end

def coupon_hash(coupon)
  price = (coupon[:cost] * 1.0 / coupon[:num]).round(2)
  {
    :item => "#{coupon[:item]} W/COUPON",
    :price => price,
    :count => coupon[:num]
  }
end
def apply_coupon_to_cart(item, coupon, cart)
  item[:count] -= coupon[:num]
  updated_item = coupon_hash(coupon)
  updated_item[:clearance] = item[:clearance]
  cart << updated_item
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart

  index = 0
  while index < coupons.count do
   coupon = coupons[index]
   discount_item = find_item_by_name_in_collection(coupon[:item], cart)
   if discount_item[:count] >= coupon[:num]
     apply_coupon_to_cart(discount_item, coupon, cart)
   end
   index += 1
 end
 cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0
  while index < cart.length do
    item = cart[index]
    if item[:clearance]
      price = (1 - 0.2) * item[:price].round(2)
      item[:price] = price
    end
    index += 1
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
    total = 0
    index = 0

    new_cart = consolidate_cart(cart)
    apply_coupons(new_cart, coupons)
    apply_clearance(new_cart)
    while index < new_cart.length do
      total += new_cart[index][:count] * new_cart[index][:price]
      index += 1
    end
  if total >= 100
    total *= (1 - 0.1)
  end
  total.round(2)
end
