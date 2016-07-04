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

  # Builds placements with product ids and quantities
  def build_placements_with_product_ids_and_quantities(product_ids_and_quantities)
    product_ids_and_quantities.each do |product_id_and_quantity|
      id, quantity = product_id_and_quantity
      self.placements.build(product_id: id)
    end
  end
end
