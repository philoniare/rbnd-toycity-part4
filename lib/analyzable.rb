module Analyzable
  # Define count_by_brand, count_by_name methods
  [:brand, :name].each do |field|
    send(:define_method, "count_by_#{field}") do |products|
      sums = Hash.new(0)
      products.each do |product|
        value = product.send(field)
        sums[value] += 1
      end
      sums
    end
  end

  def average_price(products)
    total_price = products.inject(0){|sum, product| sum + product.price.to_f}
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
