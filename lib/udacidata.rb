require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  @@count_class_instances = 0
  @@data_path = File.dirname(__FILE__) + "/../data/data.csv"

  def self.all
    self.csv_to_product(self.get_all_csv_products)
  end

  def self.create(opts = {})
    product = Product.new(opts)
    begin
      self.find(product.id)
    rescue ProductNotFoundError
      CSV.open(@@data_path, "a") do |csv|
        csv << [product.id, product.brand, product.name, product.price]
      end
    end
    product
  end

  def self.first(items = 1)
    all_csv_products = get_all_csv_products
    if items > 1
      csv_to_product(all_csv_products.take(items))
    else
      csv_to_product(all_csv_products.first).first
    end
  end

  def self.last(items = 1)
    all_csv_products = get_all_csv_products
    if items > 1
      csv_to_product(all_csv_products.last(items))
    else
      csv_to_product(all_csv_products.last).first
    end
  end

  def self.destroy(id)
    product_to_delete = self.find(id)   # => raises an error, if id not found
    self.delete_csv_row(product_to_delete.id)
    product_to_delete
  end

  # ---------------------------------------------------------------------------
  #                               Query Methods
  # ---------------------------------------------------------------------------
  def self.find(id)
    self.get_all_csv_products.each do |row|
      if row[0] == id.to_s
        return csv_to_product([row]).first
      end
    end
    raise ProductNotFoundError, "#{id} Not Found in the Database"
  end

  def self.where(opts = {})
    products = self.all
    found_products = []
    products.each do |product|
      if opts.has_key? :brand
        if product.brand == opts[:brand]
          found_products << product
        end
      else
        if product.name == opts[:name]
          found_products << product
        end
      end
    end
    found_products
  end

  # ---------------------------------------------------------------------------
  #                               Instance Methods
  # ---------------------------------------------------------------------------
  def update(opts = {})
    @brand = opts[:brand] if opts.has_key? :brand
    @price = opts[:price] if opts.has_key? :price
    @name  = opts[:name]  if opts.has_key? :name
    self.class.destroy(self.id)
    self.class.create(id: self.id, brand: self.brand,
                      name: self.name, price: self.price)
    return self
  end

  # ---------------------------------------------------------------------------
  #                               Private Methods
  # ---------------------------------------------------------------------------
  private
    def self.get_all_csv_products
      data = CSV.read(@@data_path).drop(1)
    end

    def self.csv_to_product(csv)
      products = []
      csv.each do | row |
        products << Product.new(id: row[0], brand: row[1],
          name: row[2], price: row[3])
      end
      products
    end

    def self.delete_csv_row(id)
      table = CSV.table(@@data_path)
      table.delete_if do |row|
        row[:id] == id
      end
      File.open(@@data_path, 'w') do |f|
        f.write(table.to_csv)
      end
    end
end
