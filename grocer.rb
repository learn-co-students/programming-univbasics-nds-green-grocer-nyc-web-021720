require 'pry'
def find_item_by_name_in_collection(name, collection)
  # collection => [{:item=>"DOG FOOD"}, {:item=>"WINE"}, {:item=>"STRYCHNINE"}] name => WINE
  item_index = 0
  while item_index < collection.size
    product = collection[item_index]
    if product[:item] == name
      return product
    end

  item_index += 1
  end

end

def consolidate_cart(cart)
#   # cart => [ {:item=>"TEMPEH", :price=>3.0, :clearance=>true},
#  {:item=>"PEANUTBUTTER", :price=>3.0, :clearance=>true},
#  {:item=>"ALMONDS", :price=>9.0, :clearance=>false} ]

  new_cart = []

  cart_index = 0
  while cart_index < cart.size
    item_name = cart[cart_index][:item]
    new_cart_item = find_item_by_name_in_collection(item_name, new_cart)
    # check for whatever item we are looking at using our cart_index
    # in the cart inside of our new cart
    # if this doesn't find the new item in the cart then it returns nil

    if new_cart_item != nil # if variable has a truthy value
      new_cart_item[:count] += 1
    else # if this doesn't exist yet you need to create a whole new item {}
      new_cart_item = {
        item: cart[cart_index][:item],
        price: cart[cart_index][:price],
        clearance: cart[cart_index][:clearance],
        count: 1
      }
      new_cart << new_cart_item
    end

    cart_index += 1

  end

  new_cart
end
  # Consult README for inputs and outputs
  #
  # REMEMBER: This returns a new Array that represents the cart. Don't merely
  # change `cart` (i.e. mutate) it. It's easier to return a new thing.


def apply_coupons(cart, coupons)
  i = 0
  while i < coupons.length
    cart_item = find_item_by_name_in_collection(coupons[i][:item], cart) #should return name of item on the coupon
    # want to see if item exists in the cart that's why it's 2nd argument
    #check to see if itemw/ coupon exists in cart already
    item_name_couponed = "#{coupons[i][:item]} W/COUPON"
    cart_item_couponed = find_item_by_name_in_collection(item_name_couponed, cart)

    if cart_item && cart_item[:count] >= coupons[i][:num] # amount of item within coupons
      if cart_item_couponed # increases coupons count when it already exists
        cart_item_couponed[:count] += coupons[i][:num] # increase it by the number of items on our coupons
        cart_item[:count] -= coupons[i][:num] # moves this out of cart_item into couponed so need to subtract it from there
      else
        cart_item_couponed = {
          :item => item_name_couponed,
          :price => coupons[i][:cost] / coupons[i][:num],  #TEST adds the coupon price to the property hash of couponed item
          :clearance => cart_item[:clearance], 
          :count => coupons[i][:num] #TEST adds the count number to the property hash of couponed item
        } # adds a new key, value pair to the cart hash called 'ITEM NAME W/COUPON'
        cart << cart_item_couponed #TEST  remembers if the item was on clearance
        cart_item[:count] -= coupons[i][:num] #TEST removes the number of discounted items from the original item's count
      end
    end

    i += 1
  end
  cart
end
# cart => [{:item=>"AVOCADO", :price=>3.0, :clearance=>true, :count=>2}]
# coupons => [{:item=>"AVOCADO", :num=>2, :cost=>5.0}]
# rspec spec/grocer_spec.rb -e apply_coupons

def apply_clearance(cart)
  i = 0
  while i < cart.length
    if cart[i][:clearance] # iterates over the clearance key
      cart[i][:price]  = (cart[i][:price] - (cart[i][:price] * 0.20)).round(2) # calculates clearance price
    end
    i += 1
  end
  cart # returns updated cart
end



def checkout(cart, coupons)
  consolidated_cart = consolidate_cart(cart) # calls on #consolidate_cart before calculating the total for one item
  couponed_cart = apply_coupons(consolidated_cart, coupons) # calls on #apply_coupons based on what's in coupons
  final_cart = apply_clearance(couponed_cart) # calls on #consolidate_cart before calculating the total

  total = 0

  i = 0
  while i < final_cart.length
    total += final_cart[i][:price] * final_cart[i][:count] # calculates total price * count
    i += 1
  end
  if total > 100
    total -= (total * 0.10) # applies 10% discount
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
