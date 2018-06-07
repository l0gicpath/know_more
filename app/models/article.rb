class Article < ApplicationRecord
  validates :title, presence: true, length: { in: 1..300 }
  validates :content, presence: true
end
