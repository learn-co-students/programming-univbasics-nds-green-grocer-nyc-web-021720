def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  index = 0 
  while index < collection.length do 
    if collection[index][:item] == name 
      return collection[index]
    end
    index += 1 
  end
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  updated_cart = []  
  index = 0 
  while index < cart.length do 
    new_cart = find_item_by_name_in_collection(cart[index][:item], updated_cart)
    if new_cart 
      new_cart[:count] += 1 
    else 
      new_cart = {
        :item => cart[index][:item],
        :price => cart[index][:price],
        :clearance => cart[index][:clearance],
        :count => 1 
      }
      updated_cart << new_cart
    end
index += 1 
  end
  updated_cart
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  index = 0 
  while index < coupons.length do 
    item = find_item_by_name_in_collection(coupons[index][:item], cart)
    couponed_item_name = "#{coupons[index][:item]} W/COUPON"
    cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
    if item && item[:count] >= coupons[index][:num]
      if cart_item_with_coupon
        cart_item_with_coupon[:count] += coupons[index][:num]
        item[:count] -= coupons[counter][:num]
      else 
        cart_item_with_coupon = {
          :item => couponed_item_name, 
          :price => coupons[index][:cost] / coupons[index][:num],
          :count => coupons[index][:num],
          :clearance => item[:clearance]
        }
        cart << cart_item_with_coupon
        item[:count] -= coupons[index][:num]
      end
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
  while index < cart.length 
    if cart[index][:clearance] == true
      cart[index][:price] = (cart[index][:price] - (cart[index][:price] * 0.20)).round(2)
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
  
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  clearanced_cart = apply_clearance(couponed_cart)
  results = clearanced_cart
  
  total = 0 
  index = 0 
  while index < results.length do 
    total += results[index][:price] * results[index][:count]
    index += 1 
  end 
  
  if total > 100 
    total -= (total * 0.10)
  end
  total
end
