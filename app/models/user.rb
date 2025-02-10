class User < ApplicationRecord
  has_many :picture_files, dependent: :destroy
  after_commit :log_user_saved_to_db

  private

  def log_user_saved_to_db
    Rails.logger.info("User was saved to database")
  end
end
