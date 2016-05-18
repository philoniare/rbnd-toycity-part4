require 'faker'

def db_seed
  10.times do |i|
    Product.create(id: i, brand: Faker::Company.name,
                name: Faker::Commerce.product_name, price: Faker::Commerce.price)
  end
end
