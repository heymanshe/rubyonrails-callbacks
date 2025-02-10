class AddUsername
  def self.before_validation(record)
    record.username = record.email if record.username.blank?
  end
end

class User < ApplicationRecord
  validates :username, :email, presence: true

  # before_validation :ensure_username_has_value
  # after_validation :log_validation
  # before_save :log_before_save
  # after_save :log_after_save

  # before_validation do
  #   self.username = email if username.blank?
  # end

  # before_validation ->(user) { user.username = user.email if user.username.blank? }

  before_validation AddUsername


  # private

  # def ensure_username_has_value
  #   self.username = email if username.blank?
  # end

  # def log_validation
  #   Rails.logger.info "Validation completed for User!"
  # end

  # def log_before_save
  #   Rails.logger.info "Before saving the User record!"
  # end

  # def log_after_save
  #   Rails.logger.info "User record has been saved!"
  # end
end
