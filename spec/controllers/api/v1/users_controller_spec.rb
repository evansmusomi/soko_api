require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before(:each) { request.headers['Accept'] = "application/vnd.sokoapi.v1" }

  describe "Get #show" do
    let(:user) { FactoryGirl.create(:user)}
    before(:each){ get :show, id: user.id, format: :json }

    it "returns the info about a user on a hash" do
      user_response = JSON.parse(response.body, symbolize_names: true)
      expect(user_response[:email]).to eql user.email
    end

    it { should respond_with 200 }
  end
end
