class Article < ApplicationRecord
  belongs_to :user
  after_destroy :log_destroy_action

  private

  def log_destroy_action
    Rails.logger.info("Article '#{title}' destroyed")
  end
end
