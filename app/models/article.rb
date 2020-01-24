class Article < ApplicationRecord
  validates :title, presence: true, length: { minimum: 3 }
  validates :description, presence: true, length: { minimum: 10 }
  validates :user_id, presence: true

  belongs_to :user
  has_many :article_categories
  has_many :categories, through: :article_categories
end
 