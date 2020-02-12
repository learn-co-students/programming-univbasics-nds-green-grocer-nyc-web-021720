require "pry"

def find_item_by_name_in_collection(name, collection)
    counter = 0
    while counter < collection.size do
      if collection[counter][:item] == name
        return collection[counter]
      end
      counter += 1
    end
    nil
end

def consolidate_cart(cart)
  new_cart = []
  counter = 0
    while counter < cart.size do
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
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  #binding.pry
  counter = 0
  while counter < coupons.size do
      cart_item = find_item_by_name_in_collection(coupons[counter][:item], cart)
      couponed_item_name = "#{coupons[counter][:item]} W/COUPON"
      cart_item_with_coupon = find_item_by_name_in_collection(couponed_item_name, cart)
      if cart_item && cart_item[:count] >= coupons[counter][:num]
        if cart_item_with_coupon
          cart_item_with_coupon[:count] += coupons[counter][:num]
          cart_item[:count] -= coupons[counter][:num]
        else
          cart_item_with_coupon = {
            :item => couponed_item_name,
            :price => coupons[counter][:cost] / coupons[counter][:num],
            :count => coupons[counter][:num],
            :clearance => cart_item[:clearance]
          }
          cart << cart_item_with_coupon
          cart_item[:count] -= coupons[counter][:num]
       end
     end
     counter += 1
   end
   return cart
end

def apply_clearance(cart)
  # binding.pry
  # cart = [{:item=>"TEMPEH", :price=>3.0, :clearance=>true, :count=>1}]
  discounted_cart = []
  counter = 0
  while counter < cart.size do
    if cart[counter][:item] && cart[counter][:clearance] == TRUE
      cart[counter][:price] = (cart[counter][:price] - cart[counter][:price] * 0.2).round(2)
      discounted_cart << cart[counter]
      #binding.pry
    else
      discounted_cart << cart[counter]
    end
    counter += 1
  end
  discounted_cart
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
  # binding.pry
  consolidated_cart = consolidate_cart(cart)
  couponed_cart = apply_coupons(consolidated_cart, coupons)
  final_cart = apply_clearance(couponed_cart)

  counter = 0
  total = 0
  while counter < final_cart.size do
    total += final_cart[counter][:price] * final_cart[counter][:count]

    counter += 1
  end

  if total > 100
    return total -= (total * 0.10)
  end
  total
end
