class PictureFile < ApplicationRecord
  after_commit FileDestroyerCallback
end
