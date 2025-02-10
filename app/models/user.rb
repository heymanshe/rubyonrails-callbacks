class User < ApplicationRecord
  has_many :articles, dependent: :destroy
  before_destroy :log_user_deletion, prepend: true

  private

  def log_user_deletion
    Rails.logger.info("User '#{name}' is being deleted")
  end
end
