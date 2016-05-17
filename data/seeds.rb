require 'faker'

def db_seed
  CSV.open(File.dirname(__FILE__) + "/../data/data.csv", "a") do |csv|
    10.times do |i|
      csv << [i, Faker::Company.name, Faker::Commerce.product_name, Faker::Commerce.price]
    end
  end
end
