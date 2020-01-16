
#
def find_item_by_name_in_collection(name, collection)
  collection.each do |item|
    if item[:item] == name then
      return item
    end
  end
  return nil
end

#
def consolidate_cart(cart)
  new_cart = []
  cart.each do |item|
    add_item_to_consolidated_cart(new_cart, item)
  end
  return new_cart
end

#
def add_item_to_consolidated_cart(cart, item)
  found_item = find_item_by_name_in_collection(item[:item], cart)

  if found_item then
    found_item[:count] += 1
  else
    cart << create_consolidated_item(item)
  end
end

#
def create_consolidated_item(item, count = 1)
  consolidated_item = {}
  consolidated_item[:item] = item[:item]
  consolidated_item[:price] = item[:price]
  consolidated_item[:clearance] = item[:clearance]
  consolidated_item[:count] = count
  return consolidated_item
end

#
def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons.each do |coupon|
    matching_item = find_item_by_name_in_collection(coupon[:item], cart)
    if matching_item then
      process_coupon(cart, matching_item, coupon)
    end
  end
  
  return cart
end

#
def process_coupon(cart, item, coupon)
  if item[:count] >= coupon[:num] then
    new_item = create_consolidated_item(item, coupon[:num])
    new_item[:item] += " W/COUPON"
    new_item[:price] = (coupon[:cost]/coupon[:num]).round(2)
    cart << new_item

    item[:count] -= coupon[:num]
  end
end

#
def apply_clearance(cart)
  cart.each do |item|
    if item[:clearance] then
      # 20% discount for clearance items
      item[:price] = (0.8 * item[:price]).round(2)
    end
  end
end

#
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
  
  consolidated = consolidate_cart(cart)
  apply_coupons(consolidated, coupons)
  apply_clearance(consolidated)
  
  return calculateTotal(consolidated)
end

#
def calculateTotal(cart)
  total = 0
  cart.each do |item|
    total += item[:price] * item[:count]
  end
  return apply_over_one_hundred_discount(total)
end

#
def apply_over_one_hundred_discount(total)
  if total > 100 then
    return total * 0.9
  end
  return total
end
