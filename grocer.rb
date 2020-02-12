def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  i=0 
  while i < collection.length do 
    if collection[i][:item] == name
     return collection[i]
    end
  i += 1
end
end

def consolidate_cart(cart)

new = []
i = 0 
while i < cart.length 
f=find_item_by_name_in_collection(cart[i][:item],new)
  if f != nil
  f[:count]+=1
 else 
   f= {:item => cart[i][:item],
   :price => cart[i][:price],
   :clearance => cart[i][:clearance],
     :count => 1
   }
  
 
  new << f
 end
  i += 1
  end
  new
end
# Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.


def apply_coupons(cart, coupons)
  # Consult README for inputs and outputs
i=0 
while i < coupons.length

coupon_name= find_item_by_name_in_collection(coupons[i][:item],cart)
couponed_item= "#{coupons[i][:item]} W/COUPON"
c=find_item_by_name_in_collection(couponed_item,cart)
if coupon_name && coupon_name[:count] >= coupons[i][:num]
  if c 
    c[:count] += coupons[i][:num]
  #  coupon_name[:count] -= coupons[i][:num]
else 
  c={
    :item => couponed_item ,
    :price =>  coupons[i][:cost] / coupons[i][:num],
    :count => coupons[i][:num] ,  
    :clearance =>  coupon_name[:clearance] }

cart << c
coupon_name[:count] -= coupons[i][:num]
end
end
i += 1
  # REMEMBER: This method **should** update cart
end
cart

end
def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  i=0 
  while i < cart.length 
    if cart[i][:clearance]
    cart[i][:price]=(cart[i][:price] - (cart[i][:price] * 0.20)).round(2)
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
  consolidated_price=consolidate_cart(cart)
  applyied_coupons=apply_coupons(consolidated_price,coupons)
  final=apply_clearance(applyied_coupons)
  total =0 
  i= 0 
  while i< final.length 
  total += final[i][:count] * final[i][:price]
  i += 1
  end
if total > 100 
  total-= total * 0.10 
end
total
end
