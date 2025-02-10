# Active Record Callbacks

## 1. Callbacks Order

### 1.1 Creating an Object

**Callbacks triggered when a record is created**:

+ `before_validation`
+ `after_validation`
+ `before_save`
+ `around_save`
+ `before_create`
+ `around_create`
+ `after_create`
+ `after_save`
+ `after_commit` / `after_rollback`

### 1.2 Updating an Object

**Callbacks triggered when a record is updated**:

+ `before_validation`
+ `after_validation`
+ `before_save`
+ `around_save`
+ `before_update`
+ `around_update`
+ `after_update`
+ `after_save`
+ `after_commit` / `after_rollback`

### 1.3 Destroying an Object

**Callbacks triggered when a record is destroyed**:

+ `before_destroy`
+ `around_destroy`
+ `after_destroy`
+ `after_commit` / `after_rollback`

## 2. Validation Callbacks

- Triggered before and after validation.

```ruby
class User < ApplicationRecord
  validates :name, presence: true
  before_validation :titleize_name
  after_validation :log_errors

  private
    def titleize_name
      self.name = name.downcase.titleize if name.present?
    end

    def log_errors
      Rails.logger.error("Validation failed: #{errors.full_messages.join(', ')}") if errors.any?
    end
end
```

```bash
user.valid?
```

## 3. Save Callbacks

- Triggered when an object is saved.

```ruby
class User < ApplicationRecord
  before_save :hash_password
  around_save :log_saving
  after_save :update_cache

  private
    def hash_password
      self.password_digest = BCrypt::Password.create(password)
    end

    def log_saving
      Rails.logger.info("Saving user...")
      yield
      Rails.logger.info("User saved")
    end

    def update_cache
      Rails.cache.write(["user_data", self], attributes)
    end
end
```

```bash
user = User.create(name: "Jane Doe", password: "password")
```

## 4. Create Callbacks

- Triggered when a new record is saved.

```ruby
class User < ApplicationRecord
  before_create :set_default_role
  around_create :log_creation
  after_create :send_welcome_email

  private
    def set_default_role
      self.role = "user"
    end

    def log_creation
      Rails.logger.info("Creating user...")
      yield
      Rails.logger.info("User created")
    end

    def send_welcome_email
      UserMailer.welcome_email(self).deliver_later
    end
end
```

```bash
user = User.create(name: "John Doe")
```

## 5. Update Callbacks

- Triggered when an existing record is updated.

```ruby
class User < ApplicationRecord
  before_update :check_role_change
  around_update :log_updating
  after_update :send_update_email

  private
    def check_role_change
      Rails.logger.info("User role changed to #{role}") if role_changed?
    end

    def log_updating
      Rails.logger.info("Updating user...")
      yield
      Rails.logger.info("User updated")
    end

    def send_update_email
      UserMailer.update_email(self).deliver_later
    end
end
```

```bash
user.update(role: "admin")
```

## 6. Destroy Callbacks

- Triggered when a record is destroyed.

```ruby
class User < ApplicationRecord
  before_destroy :check_admin_count
  around_destroy :log_destroy_operation
  after_destroy :notify_users

  private
    def check_admin_count
      throw :abort if admin? && User.where(role: "admin").count == 1
    end

    def log_destroy_operation
      Rails.logger.info("Destroying user...")
      yield
      Rails.logger.info("User destroyed")
    end

    def notify_users
      UserMailer.deletion_email(self).deliver_later
    end
end
```

```bash
user.destroy
```

## 7. after_initialize and after_find

- Triggered when an object is instantiated or fetched.

```ruby
class User < ApplicationRecord
  after_initialize { Rails.logger.info("Object initialized") }
  after_find { Rails.logger.info("Object found") }
end
```

```bash
User.new
User.first
```

## 8. after_touch

- Triggered when an object is touched.

```ruby
class User < ApplicationRecord
  after_touch { Rails.logger.info("Object touched") }
end
```

```bash
user.touch
```

- Can also be used with belongs_to:

```ruby
class Book < ApplicationRecord
  belongs_to :library, touch: true
  after_touch { Rails.logger.info("Book touched") }
end

class Library < ApplicationRecord
  has_many :books
  after_touch { Rails.logger.info("Library touched") }
end
```

```bash
book.touch
```

# 2. Running Callbacks

**The following methods trigger callbacks**:

- `create`

- `create!`

- `destroy`

- `destroy!`

- `destroy_all`

- `destroy_by`

- `save`

- `save!`

- `save(validate: false)`

- `save!(validate: false)`

- `toggle!`

- `touch`

- `update_attribute`

- `update_attribute!`

- `update`

- `update!`

- `valid?`

- `validate`

**Additionally, the `after_find` callback is triggered by the following finder methods**:

- `all

- `first

- `find

- `find_by

- `find_by!

- `find_by_*

- `find_by_*!

- `find_by_sql

- `last

- `sole

- `take

The `after_initialize` callback is triggered every time a new object of the class is initialized.

# 3. Conditional Callbacks

- As with validations, callbacks can be made conditional using `:if` and `:unless` options, which accept a symbol, a `Proc`, or an `array`.

## 3.1 Using `:if` and `:unless` with a Symbol

```ruby
class Order < ApplicationRecord
  before_save :normalize_card_number, if: :paid_with_card?
end
```

## 3.2 Using :if and :unless with a Proc

```ruby
class Order < ApplicationRecord
  before_save :normalize_card_number, if: ->(order) { order.paid_with_card? }
end

or

class Order < ApplicationRecord
  before_save :normalize_card_number, if: -> { paid_with_card? }
end
```

# 3.3 Multiple Callback Conditions

```ruby
class Comment < ApplicationRecord
  before_save :filter_content, if: [:subject_to_parental_control?, :untrusted_author?]
end

With a proc:

class Comment < ApplicationRecord
  before_save :filter_content, if: [:subject_to_parental_control?, -> { untrusted_author? }]
end
```

# 3.4 Using Both :if and :unless

```ruby
class Comment < ApplicationRecord
  before_save :filter_content,
    if: -> { forum.parental_control? },
    unless: -> { author.trusted? }
end
```

- The callback only runs when all `:if` conditions and none of the `:unless` conditions evaluate to `true`.

# 4. Skipping Callbacks

- Certain methods bypass callbacks, including:

+ `decrement!`

+ `decrement_counter`

+ `delete`

+ `delete_all`

+ `delete_by`

+ `increment!`

+ `increment_counter`

+ `insert`

+ `insert!`

+ `insert_all`

+ `insert_all!`

+ `touch_all`

+ `update_column`

+ `update_columns`

+ `update_all`

+ `update_counters`

+ `upsert`

+ `upsert_all`

```ruby
class User < ApplicationRecord
  before_save :log_email_change

  private

  def log_email_change
    if email_changed?
      Rails.logger.info("Email changed from #{email_was} to #{email}")
    end
  end
end
```

- To update a record without triggering `before_save`:

```bash
user = User.find(1)
user.update_columns(email: 'new_email@example.com')
```

- Skipping callbacks should be done with caution to avoid unintended side effects.




