class User < ApplicationRecord
  before_save :log_email_change

  private

  def log_email_change
    if email_changed?
      Rails.logger.info("Email changed from #{email_was} to #{email}")
    end
  end
end
