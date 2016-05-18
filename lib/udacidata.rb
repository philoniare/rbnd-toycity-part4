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
    data = CSV.read(@@data_path)
    row_destroyed = []
    CSV.open(@@data_path, "w") do |csv|
      data.each do |row|
        if row[0] != id.to_s
          csv << row
        else
          row_destroyed = row
        end
      end
    end
    Product.new(id: row_destroyed[0], brand: row_destroyed[1], name: row_destroyed[2], price: row_destroyed[3])
  end

  def update(opts = {})
    @brand = opts[:brand] if opts.has_key? :brand
    @price = opts[:price] if opts.has_key? :price
    self.class.destroy(self.id)
    self.class.create(id: self.id, brand: self.brand, name: self.name, price: self.price)
    return self
  end

  def self.find(id)
    data = CSV.read(@@data_path).drop(1)
    data.each do |product_row|
      if product_row[0].to_i == id
        return Product.new(id: product_row[0], brand: product_row[1], name: product_row[2], price: product_row[3])
      end
    end
    return nil
  end

  def self.find_by_brand(brand)
    products = self.all
    products.each do |product|
      if product.brand == brand
        return product
      end
    end
  end

  def self.find_by_name(name)
    products = self.all
    products.each do |product|
      if product.name == name
        return product
      end
    end
  end

  def self.where(opts = {})
    products = self.all
    found_products = []
    products.each do |product|
      if product.brand == opts[:brand]
        found_products << product
      end
    end
    found_products
  end
end
