class Product < ActiveRecord::Base

  # Associations
  belongs_to :user

  # Validations
  validates :title, :user_id, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }, presence: true

  # Filters by title
  scope :filter_by_title, lambda {|keyword|
    where("lower(title) LIKE ?", "%#{keyword.downcase}%")
  }

  # Filters by price upwards
  scope :above_or_equal_to_price, lambda {|price|
    where("price >= ?", price)
  }

  # Filters by price downwards
  scope :below_or_equal_to_price, lambda {|price|
    where("price <= ?", price)
  }

  # Orders by recency
  scope :recent, -> {
    order(:updated_at)
  }
end
