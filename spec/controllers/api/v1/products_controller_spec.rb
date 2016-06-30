require 'rails_helper'

RSpec.describe Api::V1::ProductsController, type: :controller do
  describe "GET #show" do
    let(:product){ FactoryGirl.create :product }
    before(:each) do
      get :show, id: product.id
    end

    it "returns the information about the product on a hash" do
      product_response = json_response
      expect(product_response[:title]).to eql product.title
    end

    it { should respond_with 200 }
  end

  describe "GET #index" do
    before(:each) do
      4.times { FactoryGirl.create :product }
      get :index
    end

    it "returns 4 records from the database" do
      products_response = json_response
      expect(products_response.length).to eq(4)
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is successfully created" do
      let(:user){ FactoryGirl.create :user }
      let(:product_attributes){ FactoryGirl.attributes_for :product }
      before(:each) do
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, product: product_attributes }
      end

      it "renders the json representation for the product record just created" do
        product_response = json_response
        expect(product_response[:title]).to eql product_attributes[:title]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      let(:user){ FactoryGirl.create :user }
      let(:invalid_product_attributes){ {title: "Smart TV", price: "Hundred dollars"}}
      before(:each) do
        api_authorization_header user.auth_token
        post :create, { user_id: user.id, product: invalid_product_attributes }
      end

      it "renders an errors json" do
        product_response = json_response
        expect(product_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        product_response = json_response
        expect(product_response[:errors][:price]).to include "is not a number"
      end

      it { should respond_with 422 }
    end
  end
end
