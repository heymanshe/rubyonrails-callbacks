class BirthdayCake < ApplicationRecord
  around_save :log_around_save
  after_initialize :log_initialization
  before_create :set_default_flavour
  after_create :log_creation
  before_update :log_before_update
  after_update :log_after_update
  before_destroy :log_before_destroy
  after_destroy :log_after_destroy
  before_validation :normalize_name
  after_validation :log_validation

  private

  def normalize_name
    self.name = name.strip.capitalize if name.present?
  end

  def log_validation
    Rails.logger.info "Validation completed for BirthdayCake!"
  end

  def log_around_save
    Rails.logger.info "Before saving the cake!"
    yield # This runs the actual save operation
    Rails.logger.info "After saving the cake!"
  end

  def log_initialization
    Rails.logger.info "A new BirthdayCake object has been initialized!"
  end

  def set_default_flavour
    self.flavour ||= "Vanilla"
  end

  def log_creation
    Rails.logger.info "A new BirthdayCake has been created!"
  end

  def log_before_update
    Rails.logger.info "A BirthdayCake is about to be updated!"
  end

  def log_after_update
    Rails.logger.info "A BirthdayCake has been updated!"
  end

  def log_before_destroy
    Rails.logger.info "A BirthdayCake is about to be destroyed!"
  end

  def log_after_destroy
    Rails.logger.info "A BirthdayCake has been destroyed!"
  end
end
