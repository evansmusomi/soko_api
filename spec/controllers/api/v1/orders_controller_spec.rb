require 'rails_helper'

RSpec.describe Api::V1::OrdersController, type: :controller do
  describe "GET #index" do
    let(:current_user){ FactoryGirl.create :user}
    before(:each) do
      api_authorization_header current_user.auth_token
      4.times { FactoryGirl.create :order, user: current_user }
      get :index, user_id: current_user.id
    end

    it "returns 4 order records from the user" do
      orders_response = json_response
      expect(orders_response.size).to eq(4)
    end

    it { should respond_with 200 }
  end

  describe "GET #show" do
    let(:current_user){ FactoryGirl.create :user }
    let(:order){ FactoryGirl.create :order, user: current_user }
    before(:each) do
      api_authorization_header current_user.auth_token
      get :show, user_id: current_user.id, id: order.id
    end

    it "returns the user order record matching the id" do
      order_response = json_response
      expect(order_response[:id]).to eql order.id
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do

  end
end
