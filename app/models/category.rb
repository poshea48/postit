class Category < ActiveRecord::Base
  include Sluggable
  has_many :post_categories
  has_many :posts, through: :post_categories

  before_save :generate_slug

  validates :name, presence: true

  sluggable_column :name
end
