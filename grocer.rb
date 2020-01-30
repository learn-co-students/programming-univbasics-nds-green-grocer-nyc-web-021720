def find_item_by_name_in_collection(name, collection)
  i = 0 
  while i < collection.size do
    if collection[i][:item] == name
      return collection[i]
    end
    i += 1
  end
  return nil  
end

def consolidate_cart(cart)
  new_cart = []
  i = 0 
  while i < cart.size do
    cart[i][:count] = 1
    if not new_cart.include?(cart[i])
      new_cart << cart[i]
    else 
      k = 0
      while k < new_cart.size do
        if new_cart[k][:item] == cart[i][:item]
          new_cart[k][:count] += 1
        end
        k += 1
      end
    end
    i += 1
  end
  return new_cart
end


def apply_coupons(cart, coupons)
  coupons_index = 0
  while coupons_index < coupons.length do
    item = coupons[coupons_index][:item]
    cart_item = find_item_by_name_in_collection(item, cart)
    
    couponed_item_name = "#{coupons[coupons_index][:item]} W/COUPON"
    couponed_item = find_item_by_name_in_collection(couponed_item_name, cart)
     binding.pry
    if cart_item && cart_item[:count] >= coupons[coupons_index][:num]
      if couponed_item != nil
        couponed_item[:count] += coupons[coupons_index][:num]
        cart_item[:count] -= coupons[coupons_index][:num]
      else
        couponed_item = {
          :item => couponed_item_name,
          :price => coupons[coupons_index][:cost]/coupons[coupons_index][:num], 
          :clearance => cart_item[:clearance],
          :count => coupons[coupons_index][:num]
          }
          cart << couponed_item
          
          cart_item[:count] -= coupons[coupons_index][:num]
      end
    end
    coupons_index += 1
  end
 
  return cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
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
end
