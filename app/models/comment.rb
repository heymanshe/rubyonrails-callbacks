class Comment < ApplicationRecord
  # before_save :filter_content, if: [ :subject_to_parental_control?, -> { untrusted_author? } ]

  before_save :filter_content,
  if: -> { parental_control_enabled },
  unless: -> { author_trusted }

  private

  def filter_content
    self.content = "[Filtered]" if content.include?("badword")
    Rails.logger.info("Comment filtered due to policy")
  end

  def subject_to_parental_control?
    parental_control_enabled
  end

  def untrusted_author?
    !author_trusted
  end
end
