class Upload < ApplicationRecord
  mount_uploaders :images, ImageUploader
  serialize :images, JSON  # SQLite 에서만 사용하는 구문
end
