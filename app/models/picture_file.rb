class PictureFile < ApplicationRecord
  # belongs_to :user

  # after_destroy_commit :delete_picture_file_from_disk

  # private

  # def delete_picture_file_from_disk
  #   if File.exist?(filepath)
  #     File.delete(filepath)
  #   end
  # end
  #
  #
  #
  #
  # after_rollback :log_transaction_failure

  # private

  # def log_transaction_failure
  #   Rails.logger.info("User transaction failed")
  # end
  #

  # after_create_commit :log_user_created
  # after_update_commit :log_user_updated

  # private

  # def log_user_created
  #   Rails.logger.info("User was created in database")
  # end

  # def log_user_updated
  #   Rails.logger.info("User was updated in database")
  # end
  #
  #


  # after_save_commit :log_user_saved

  # private

  # def log_user_saved
  #   Rails.logger.info("User was saved (create or update)")
  # end

  after_commit { Rails.logger.info("This gets called first") }
  after_commit { Rails.logger.info("This gets called second") }
end
