class User < ApplicationRecord
  # Validation Callbacks
  before_validation :titleize_name
  after_validation :log_errors

  # Save Callbacks
  before_save :hash_password
  around_save :log_saving
  after_save :update_cache

  # Create Callbacks
  before_create :set_default_role
  around_create :log_creation
  after_create :send_welcome_email

  # Update Callbacks
  before_update :check_role_change
  around_update :log_updating
  after_update :send_update_email

  # Destroy Callbacks
  before_destroy :check_admin_count
  around_destroy :log_destroy_operation
  after_destroy :notify_users

  # Initialize & Find Callbacks
  after_initialize { Rails.logger.info("You have initialized an object!") }
  after_find { Rails.logger.info("You have found an object!") }

  private

  def titleize_name
    self.name = name.downcase.titleize if name.present?
    Rails.logger.info("Name titleized to #{name}")
  end

  def log_errors
    Rails.logger.error("Validation failed: #{errors.full_messages.join(', ')}") if errors.any?
  end

  def hash_password
    self.password = "hashed_#{password}" # Simulated password hashing
    Rails.logger.info("Password hashed for user with email: #{email}")
  end

  def log_saving
    Rails.logger.info("Saving user with email: #{email}")
    yield
    Rails.logger.info("User saved with email: #{email}")
  end

  def update_cache
    Rails.cache.write([ "user_data", self ], attributes)
    Rails.logger.info("Update Cache")
  end

  def set_default_role
    self.role = "user" if role.blank?
    Rails.logger.info("User role set to default: user")
  end

  def log_creation
    Rails.logger.info("Creating user with email: #{email}")
    yield
    Rails.logger.info("User created with email: #{email}")
  end

  def send_welcome_email
    Rails.logger.info("User welcome email sent to: #{email}")
  end

  def check_role_change
    Rails.logger.info("User role changed to #{role}") if role_changed?
  end

  def log_updating
    Rails.logger.info("Updating user with email: #{email}")
    yield
    Rails.logger.info("User updated with email: #{email}")
  end

  def send_update_email
    Rails.logger.info("Update email sent to: #{email}")
  end

  def check_admin_count
    if role == "admin" && User.where(role: "admin").count == 1
      throw :abort
    end
    Rails.logger.info("Checked the admin count")
  end

  def log_destroy_operation
    Rails.logger.info("About to destroy user with ID #{id}")
    yield
    Rails.logger.info("User with ID #{id} destroyed successfully")
  end

  def notify_users
    Rails.logger.info("Notification sent to other users about user deletion")
  end
end
