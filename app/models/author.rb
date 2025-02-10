class Author < ApplicationRecord
  # has_many :books, before_add: [ :check_limit, :calculate_shipping_charges ]

  # private

  # def check_limit(_book)
  #   if books.count >= 5
  #     errors.add(:base, "Cannot add more than 5 books for this author")
  #     throw(:abort)
  #   end
  # end

  # def calculate_shipping_charges(book)
  #   weight = book.weight_in_pounds || 1
  #   shipping_charges = weight * 2
  #   Rails.logger.info("Shipping charges for book '#{book.title}': $#{shipping_charges}")
  # end
  has_many :books, before_add: [ :check_limit, :calculate_shipping_charges ], before_remove: :ensure_at_least_one_book

  private

  def ensure_at_least_one_book(book)
    if books.count == 1
      errors.add(:base, "Cannot remove the last book of an author")
      throw(:abort)
    end
  end
end
