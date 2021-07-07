items = [  
 {:item=>"AVOCADO", :price=>3.0, :clearance=>true},
 {:item=>"KALE", :price=>3.0, :clearance=>false},
 {:item=>"BLACK_BEANS", :price=>2.5, :clearance=>false},
 {:item=>"ALMONDS", :price=>9.0, :clearance=>false},
 {:item=>"TEMPEH", :price=>3.0, :clearance=>true},
 {:item=>"CHEESE", :price=>6.5, :clearance=>false},
 {:item=>"BEER", :price=>13.0, :clearance=>false},
 {:item=>"PEANUTBUTTER", :price=>3.0, :clearance=>true},
 {:item=>"BEETS", :price=>2.5, :clearance=>false},
 {:item=>"SOY MILK", :price=>4.5, :clearance=>true}
 ]
 
 puts items[0][:item]
 
 # after doing the consolidate_cart
 [{:item=>"AVOCADO", :price=>3.0, :clearance=>true, :count=>1},
 {:item=>"KALE", :price=>3.0, :clearance=>false, :count=>1},
 {:item=>"BLACK_BEANS", :price=>2.5, :clearance=>false, :count=>1},
 {:item=>"ALMONDS", :price=>9.0, :clearance=>false, :count=>1},
 {:item=>"TEMPEH", :price=>3.0, :clearance=>true, :count=>1},
 {:item=>"CHEESE", :price=>6.5, :clearance=>false, :count=>1},
 {:item=>"BEER", :price=>13.0, :clearance=>false, :count=>1},
 {:item=>"PEANUTBUTTER", :price=>3.0, :clearance=>true, :count=>1},
 {:item=>"BEETS", :price=>2.5, :clearance=>false, :count=>1},
 {:item=>"SOY MILK", :price=>4.5, :clearance=>true, :count=>1}]