class ProductNotFoundError < StandardError
  def initialize(msg="Error has occurred")
    super
  end
end
