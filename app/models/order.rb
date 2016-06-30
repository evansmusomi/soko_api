class Order < ActiveRecord::Base
  # Hooks
  before_validation :set_total!

  # Associations
  belongs_to :user
  has_many :placements
  has_many :products, through: :placements

  # Validations
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validates :user_id, presence: true

  # Sets total
  def set_total!
    self.total = products.map(&:price).sum
  end
end
