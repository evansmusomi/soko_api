class UserSerializer < ActiveModel::Serializer
  attributes :id, :email, :created_at, :updated_at, :auth_token, :product_ids

  # Have product ids embedded
  def product_ids
    object.products.pluck(:id)
  end
end
