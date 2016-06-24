require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:product){ FactoryGirl.build :product }
  subject { product }

  # Valid Factory
  it "has a valid Factory" do
    expect(product).to be_valid
  end

  # Responds to attributes
  it { should respond_to(:title) }
  it { should respond_to(:price) }
  it { should respond_to(:published) }
  it { should respond_to(:user_id) }

  # Validations
  it { should validate_presence_of :title }
  it { should validate_presence_of :price }
  it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  it { should validate_presence_of :user_id }
end
