def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  collection.detect {|i| i[:item] == name}
end

def consolidate_cart(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
  cart_consolidation = []
  cart.each do |item|
    if (cart_consolidation.detect {|i| i[:item] == item[:item] })
      cart_consolidation.detect {|i| i[:item] == item[:item]}[:count]+=1
    else
      cart_consolidation<<item.merge({:count=>1})
    end
  end
  cart_consolidation
end

def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  coupons.each do |coupon|
     if (coupon_applicable?(cart,coupon))
       number_of_times_coupon_applies = times_coupon_is_applicable(cart,coupon)
       applying_coupon(cart,coupon,number_of_times_coupon_applies)
     end
  end
  cart
end

def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart.each do |item|
    if item[:clearance]
      item[:price] = (item[:price] * 0.8).round(2)
    end
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
  cart = consolidate_cart(cart)
  apply_coupons(cart,coupons)
  apply_clearance(cart)
  total = 0
  cart.each do |item|
    total+= item[:price] * item[:count]
  end
  total*=0.9 if total > 100
  total
end

def coupon_applicable?(c_cart,coupon)
  c_cart.detect {|i| i[:item] == coupon[:item] } &&
  c_cart.detect {|i| i[:item] == coupon[:item] }[:count] >= coupon[:num]
end

def times_coupon_is_applicable(c_cart,coupon)
  c_cart.detect {|i| i[:item] == coupon[:item] }[:count] / coupon[:num]
end

def applying_coupon(c_cart,coupon,number_of_times_coupon_applies)
  cart_product = c_cart.detect {|i| i[:item] == coupon[:item] }
  cart_product[:count] -= coupon[:num] * number_of_times_coupon_applies
  c_cart << {
        :item=>"#{cart_product[:item]} W/COUPON",
        :price=>(coupon[:cost]/coupon[:num]),
        :clearance=>cart_product[:clearance],
        :count=> (coupon[:num]*number_of_times_coupon_applies)
      }
end
PRODUCTS = [
  {:item => "PEANUT BUTTER", :price => 3.00, :clearance => true,  :count => 2},
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 3},
  {:item => "SOY MILK", :price => 4.50, :clearance => true,  :count => 1}
]
cart =[]
cart << find_item_by_name_in_collection("KALE",PRODUCTS)
puts checkout(cart,[])
[
  {:item => "PEANUT BUTTER", :price => 3.00, :clearance => true,  :count => 2},
  {:item => "KALE", :price => 3.00, :clearance => false, :count => 3},
  {:item => "SOY MILK", :price => 4.50, :clearance => true,  :count => 1}
]
