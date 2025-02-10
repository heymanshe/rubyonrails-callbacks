class Product < ApplicationRecord
  # before_validation do
  #   raise "Price can't be negative" if total_price && total_price < 0
  # end
  before_validation do
    throw :abort if total_price && total_price < 0
  end
end
