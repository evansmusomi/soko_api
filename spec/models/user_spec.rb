require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user)}

  it "has a valid factory" do
    expect(user).to be_valid
  end
  
  #Responds to methods
  context "responds to its methods" do
    it { expect(user).to respond_to(:email) }
    it { expect(user).to respond_to (:password) }
    it { expect(user).to respond_to (:password_confirmation) }
  end
end
