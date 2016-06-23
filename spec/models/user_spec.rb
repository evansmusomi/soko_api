require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { FactoryGirl.build(:user)}

  it "has a valid factory" do
    expect(user).to be_valid
  end

  #Responds to methods
  it { expect(user).to respond_to(:email) }
  it { expect(user).to respond_to (:password) }
  it { expect(user).to respond_to (:password_confirmation) }

  #Validations
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive }
  it { should validate_confirmation_of(:password) }
  it { should allow_value('example@domain.com').for(:email) }

end
