module Analyzable
  def count_by_brand(products)
    counts = Hash.new
    products.each do |product|
      if counts.has_key? product.brand
        counts[product.brand] += 1
      else
        counts[product.brand] = 1
      end
    end
    counts
  end
  def count_by_name(products)
    counts = Hash.new
    products.each do |product|
      if counts.has_key? product.name
        counts[product.name] += 1
      else
        counts[product.name] = 1
      end
    end
    counts
  end
  def average_price(products)
    total_price = 0
    products.each do |product|
      total_price += product.price.to_f
    end
    (total_price / products.length).round(2)
  end
  def print_report(products)
    report = "Average Price: #{average_price(products)}\n"
    report += "Inventory by Brand: \n"
    count_by_brand(products).each do |brand, count|
      report += "   - #{brand}: #{count}\n"
    end
    report += "Inventory by Name: \n"
    count_by_name(products).each do |brand, count|
      report += "   - #{brand}: #{count}\n"
    end
    report
  end
end
