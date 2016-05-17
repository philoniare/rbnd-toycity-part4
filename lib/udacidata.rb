require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  @@count_class_instances = 0
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"

  def self.all
    products = []
    CSV.foreach(@@data_path) do |product_row|
      if product_row[0] != "id"
        product = Product.new(id: product_row[0], brand: product_row[1],
          name: product_row[2], price: product_row[3])
        products << product
      end
    end
    products
  end
  def self.create(opts = {})
    product = Product.new(opts)
    if self.find(product.id) == nil
      CSV.open(@@data_path, "a") do |csv|
        csv << [product.id, product.brand, product.name, product.price]
      end
    end
    product
  end

  def self.first(n = 1)
    first_products = []
    count = 0
    CSV.foreach(@@data_path) do |product_row|
      if product_row[0] != "id"
        count += 1
        product = Product.new(id: product_row[0], brand: product_row[1],
          name: product_row[2], price: product_row[3])
        first_products << product
      end
      break if count >= n
    end
    n == 1 ? first_products.first : first_products
  end

  def self.last(n = 1)
    data = CSV.read(@@data_path).drop(1)
    last_products = []
    data[data.size-n, data.size].each do |product_row|
      product = Product.new(id: product_row[0], brand: product_row[1],
        name: product_row[2], price: product_row[3])
      last_products << product
    end
    n == 1 ? last_products.first : last_products
  end
  
  def self.destroy(id)
    # Delete the object with id and return that object
    # raise error if not in db
  end
  def self.update

  end

  def self.find(id)
    data = CSV.read(@@data_path).drop(1)
    product = []
    data.each do |product_row|
      if product_row[0] == id
        puts "#{product_row[0]} ------ #{id}"
        product << Product.new(id: product_row[0], brand: product_row[1], name: product_row[2], price: product_row[3])
      end
    end
    product.first
  end

end
