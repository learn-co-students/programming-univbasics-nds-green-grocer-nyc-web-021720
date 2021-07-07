require "pry"
def find_item_by_name_in_collection(name, collection)
  # Implement me first!
 # new_hash = {}
 
   row_index = 0 
  
   while row_index < collection.length do
     
   collection[row_index]
   
   if name == collection[row_index][:item]
   
    
   
    return collection[row_index]
  #else
   # return nil
  end
   row_index += 1
  
 end
 
  # Consult README for inputs and outputs
end

def consolidate_cart(cart)
  cartnew_hash = {}
  
 
  new_array = []
  
   row_index = 0
   match_item = {}
  
   while row_index < cart.length do
  
    match_item = find_item_by_name_in_collection(cart[row_index][:item],new_array)

           if    match_item  
             
           match_item[:count] += 1
         #scound_hash = find_item_by_name_in_collection(cartnew_hash[row_index][:item],cart)
     else   
           match_item = {:item =>cart[row_index][:item] ,:price =>cart[row_index][:price] ,:clearance =>cart[row_index][:clearance],:count =>1}
 
            
           #binding.pry
      
         #elsif  cartnew_hash[row_index][:item] == if  #cartnew_hash[row_index+1][:item]
      
               
     
     
  end
 
   
   new_array << match_item 
  row_index += 1
  end

 

  new_array

  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.
end

def apply_coupons(cart, coupons)
  
 
  row_index = 0 
  
  while row_index < coupons.length 
  
  
cart_iteam = find_item_by_name_in_collection(coupons[row_index][:item],cart)
 
 
   couponed_item_name = "#{coupons[row_index][:item]} W/COUPON"
   cart_iteam_with_coupon = find_item_by_name_in_collection(couponed_item_name,cart)
  
     if  cart_iteam  && cart_iteam[:count] >= coupons[row_index][:num]
        
   if  cart_iteam_with_coupon
      
   cart_iteam_with_coupon[:count] += coupons[row_index][:num]
  
   cart_iteam[:count] -= coupons[row_index][:num]
   
     else
    cart_iteam_with_coupon = {
      :item => couponed_item_name ,
      :price => coupons[row_index][:cost]/coupons[row_index][:num],
      :count => coupons[row_index][:num],
      :clearance => cart_iteam[:clearance]
      
    } 
    
    cart << cart_iteam_with_coupon
    cart_iteam[:count] -= coupons[row_index][:num]
  
end

end
row_index += 1

end
  
 return cart
  #same_iteamwithcoupion = find_item_by_name_in_collection(name_iteamwithcoupon,cart)
 
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
end

def apply_clearance(cart)
 
    row_index = 0 

   
  while row_index < cart.length do
    
   
      if cart[row_index][:clearance] == true 
     
    price = cart[row_index][:price]
      clearance_discount = 0.2 * cart[row_index][:price]
 cart[row_index][:price] = (price - clearance_discount).round(2)
  
   end

 
  # Consult README for inputs and outputs
  # REMEMBER: This method **should** update cart
  
  
  row_index += 1

  
end

return cart

end
def checkout(cart, coupons)
     #new_array = []

    row_index = 0 
    total = 0  
 consolidate_cart = consolidate_cart(cart)

items_with_coupons = apply_coupons(consolidate_cart, coupons)

final_cart = apply_clearance(items_with_coupons)
 
  while row_index < final_cart.length 
total += final_cart[row_index][:price] * final_cart[row_index][:count]
        
   row_index += 1
    
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
  
if total > 100
  total -=  (total * 0.1)
end

 return total
end
