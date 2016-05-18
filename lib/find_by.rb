class Module
  def method_missing(method_name, *args, &block)
    name = method_name.to_s.downcase
    if(match_data = /^find_by_()(\w*?)?$/.match name)
      create_finder_methods match_data[2]
      send(method_name, *args)
    else
      super(method_name, *args)
    end
  end

  def create_finder_methods(*attributes)
    attributes.each do |attr|
      attr_name = attr.to_s
      method_name = "find_by_#{attr_name}"
      method = %Q{
        def #{method_name}(identifier)
          self.all.select{ |product| product.#{attr_name}.to_s == identifier.to_s }.first
        end
      }
      self.instance_eval(method)
    end
  end
end
