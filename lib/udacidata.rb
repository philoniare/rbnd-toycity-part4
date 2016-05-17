require_relative 'find_by'
require_relative 'errors'
require 'csv'

class Udacidata
  def initialize
    # create missing_methods for find_by_attr
  end
  def all

  end
  def create
    # Will not save if:
    # - attributes are already present, return a newly created object
    # - attributes repr. object that doesn't exist in the db. Pass to new and save
  end
  def first(n = 1)

  end
  def last(n = 1)

  end
  def destroy(id)
    # Delete the object with id and return that object
    # raise error if not in db
  end
  def update

  end
  def find(id)
    # raise error if not in db
  end

end


# Demo:
# CSV.open("demo.csv", "wb") do |csv|
#   10.times do |r|
#     csv << [r, r, r, r]
#   end
# end
