class User < ApplicationRecord
  has_many :notifications

  # after_create :create_welcome_notification
  # after_create :log_creation

  # def create_welcome_notification
  #   notifications.create(event: "sign_up")
  # end

  # def log_creation
  #   Rails.logger.info("User #{name} was created.")
  # end
  after_create :create_welcome_notification, unless: -> { @skip_notifications }

  def create_welcome_notification
    notifications.create(event: "sign_up")
  end

  def create_without_notifications
    @skip_notifications = true
    save
  ensure
    @skip_notifications = false
  end
end
