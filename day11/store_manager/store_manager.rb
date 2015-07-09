require 'sinatra'

class Product
  attr_reader :id, :name, :price, :brand, :details

  def initialize(hash)
    @id = hash[:id]
    @name = hash[:name]
    @price = hash[:price]
    @brand = hash[:brand]
    @details = hash[:details]
  end
end

def get_new_id(products)
  if products.empty?
    0
  else
    products.last.id + 1 
  end
end

def delete_product(products,id)
  products.delete_if do |product|
    product.id == id
  end  
end

def find_product(products,id)
  products.select do |product|
    product.id == id
  end[0]
end

products = [
  Product.new({ id: 0, name: "samsung galaxy s6 edge", price: 829.90, brand: "samsung", details: "samsung rule" }),
  Product.new({ id: 1, name: "lg g flex", price: 689.90, brand: "lg", details: "lg is better" }),
  Product.new({ id: 2, name: "apple iphone 6 plus", price: 779.90, brand: "apple", details: "apple apple" }),
  Product.new({ id: 3, name: "samsung galaxy alpha", price: 589.90, brand: "samsung", details: "samsung rule" }),
  Product.new({ id: 4, name: "nokia lumia 930", price: 489.90, brand: "nokia", details: "" }),
  Product.new({ id: 5, name: "sony xperia z3 compact", price: 389.90, brand: "sony", details: "" }),
  Product.new({ id: 6, name: "apple iphone 6", price: 779.90, brand: "apple", details: "" }),
  Product.new({ id: 7, name: "huawei ascend g7", price: 259.90, brand: "huawei", details: "" }),
  Product.new({ id: 8, name: "sony xperia t2 ultra", price: 359.90, brand: "sony", details: "" }),
  Product.new({ id: 9, name: "lg g4", price: 589.90, brand: "lg", details: "" }),
  Product.new({ id: 10, name: "samsung galaxy note 4", price: 689.90, brand: "samsung", details: "samsung rule" }),
  Product.new({ id: 11, name: "htc one m9", price: 674.90, brand: "htc", details: "" }),
  Product.new({ id: 12, name: "apple iphone 5s", price: 589.90, brand: "apple", details: "" })
]

get '/' do
  
  @products = products
  erb :grid
  # erb :index
end

post '/new' do
  id = get_new_id(products)
  products << Product.new({:id => id,:name => params[:name],:price => params[:price].to_i,:brand => params[:brand], :details => params[:details]})
  @products = products
  erb :index
end

get '/remove/:id' do
    delete_product(products, params[:id].to_i)
    @products = products
    erb :index
end

get '/show/:id' do
    @product = find_product(products, params[:id].to_i)
    erb :show
end

get '/edit/:id' do
  @product = find_product(products, params[:id].to_i)
  erb :edit
end

get '/update/:id' do
  products[params[:id].to_i] = Product.new({:id => params[:id].to_i,:name => params[:name],:price => params[:price].to_i,:brand => params[:brand], :details => params[:details]})
  redirect "/show/#{params[:id]}"
end