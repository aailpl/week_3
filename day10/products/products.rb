require 'sinatra'

class Product
  attr_reader :name, :price, :brand

  def initialize(hash)
    @name = hash[:name]
    @price = hash[:price]
    @brand = hash[:brand]
  end
end

products = [
  Product.new({ name: "samsung galaxy s6 edge", price: 829.90, brand: "samsung" }),
  Product.new({ name: "lg g flex", price: 689.90, brand: "lg" }),
  Product.new({ name: "apple iphone 6 plus", price: 779.90, brand: "apple" }),
  Product.new({ name: "samsung galaxy alpha", price: 589.90, brand: "samsung" }),
  Product.new({ name: "nokia lumia 930", price: 489.90, brand: "nokia" }),
  Product.new({ name: "sony xperia z3 compact", price: 389.90, brand: "sony" }),
  Product.new({ name: "apple iphone 6", price: 779.90, brand: "apple" }),
  Product.new({ name: "huawei ascend g7", price: 259.90, brand: "huawei" }),
  Product.new({ name: "sony xperia t2 ultra", price: 359.90, brand: "sony" }),
  Product.new({ name: "lg g4", price: 589.90, brand: "lg" }),
  Product.new({ name: "samsung galaxy note 4", price: 689.90, brand: "samsung" }),
  Product.new({ name: "htc one m9", price: 674.90, brand: "htc" }),
  Product.new({ name: "apple iphone 5s", price: 589.90, brand: "apple" })
]

get '/' do
  @products = products
  erb :show
end