class Order < ApplicationRecord
  before_save :normalize_card_number, if: :paid_with_card?

  private

  def normalize_card_number
    self.card_number = "XXXX-XXXX-XXXX-" + card_number[-4..] if card_number.present?
    Rails.logger.info("Card number masked")
  end

  def paid_with_card?
    payment_type == "card"
  end
end
