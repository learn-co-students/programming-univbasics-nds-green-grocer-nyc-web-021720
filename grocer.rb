def find_item_by_name_in_collection(name, collection)
i = 0 
while i < collection.length 
index = collection[i]
if index[:item] == name 
  return index
end 
i += 1 
end
 end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  new_cart = []
  counter = 0 
  while counter < cart.length 
  new_cart_item = find_item_by_name_in_collection(cart[counter][:item], new_cart)
 if new_cart_item != nil 
   new_cart_item[:count] += 1
 else
  new_cart_item = {
    :item => cart[counter][:item],
    :price => cart[counter][:price],
    :clearance => cart[counter][:clearance],
    :count => 1
  }
  new_cart << new_cart_item
 end
  counter += 1 
end
new_cart
end
  
  
  
  
  
  def apply_coupons(cart, coupons)
  i = 0 
  while i < coupons.length
  cart_item = find_item_by_name_in_collection(coupons[i][:item], cart)
  coupon_item_name = "#{coupons[i][:item]} W/COUPON"
  cart_item_with_coupon = find_item_by_name_in_collection(coupon_item_name, cart)
  if cart_item && cart_item[:count] >= coupons[i][:num]
    if cart_item_with_coupon 
      cart_item_with_coupon[:count] += coupons[i][:num]
      cart_item[:count] -= coupons[i][:num]
    else
      cart_item_with_coupon = {
        :item => coupon_item_name,
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
  cart[i][:price] = (cart[i][:price]-(cart[i][:price]*0.20 )).round(2)
end
i += 1 
end
cart
end

def checkout(cart, coupons)
  consolidated_cart= consolidate_cart(cart)
  applied = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(applied)
  i = 0 
  total = 0 
  while i < final_cart.length
  total += final_cart[i][:count] * final_cart[i][:price]
   i += 1
end
if total > 100
  total -= (total * 0.10 )
end
total
end
# Consult README for inputs and outputs
#
# This method should call
# * consolidate_cart
# * apply_coupons
# * apply_clearance
#
# BEFORE it begins the work of calculating the total (or else you might have
# some irritated customers