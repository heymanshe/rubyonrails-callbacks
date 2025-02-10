class User < ApplicationRecord
  before_validation :normalize_name
  after_validation :log_validation
  before_save :hash_password
  after_save :log_save
  before_create :set_default_role
  after_create :send_welcome_email
  before_update :log_before_update
  after_update :log_after_update
  before_destroy :log_before_destroy
  after_destroy :log_after_destroy
  after_initialize :log_after_initialize
  after_find :log_after_find
  after_touch :log_after_touch

  private

  def normalize_name
    self.name = name.strip.titleize if name.present?
    Rails.logger.info("Normalized name: #{name}")
  end

  def log_validation
    Rails.logger.info("Validation completed with errors: #{errors.full_messages}") if errors.any?
  end

  def hash_password
    self.password = "hashed_#{password}" # Simulating password hashing
    Rails.logger.info("Password hashed for #{email}")
  end

  def log_save
    Rails.logger.info("User #{email} has been saved")
  end

  def set_default_role
    self.role ||= "user"
    Rails.logger.info("Default role set to #{role}")
  end

  def send_welcome_email
    Rails.logger.info("Welcome email sent to #{email}")
  end

  def log_before_update
    Rails.logger.info("Updating user #{email}")
  end

  def log_after_update
    Rails.logger.info("User #{email} updated")
  end

  def log_before_destroy
    Rails.logger.info("Destroying user #{email}")
  end

  def log_after_destroy
    Rails.logger.info("User #{email} destroyed")
  end

  def log_after_initialize
    Rails.logger.info("User object initialized")
  end

  def log_after_find
    Rails.logger.info("User record found")
  end

  def log_after_touch
    Rails.logger.info("User record touched")
  end
end
