require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  before(:each) { request.headers['Accept'] = "application/vnd.sokoapi.v1" }

  describe "GET #show" do
    let(:user) { FactoryGirl.create :user }
    before(:each){ get :show, id: user.id, format: :json }

    it "returns the info about a user on a hash" do
      user_response = json_response
      expect(user_response[:email]).to eql user.email
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do
    context "when is successfully created" do
      let(:user_attributes){ FactoryGirl.attributes_for :user }
      before(:each){ post :create, { user: user_attributes}, format: :json }

      it "renders the json representation for the user record just created" do
        user_response = json_response
        expect(user_response[:email]).to eql user_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      let(:invalid_user_attributes){ FactoryGirl.attributes_for :user, email:nil }
      before(:each){ post :create, { user: invalid_user_attributes}, format: :json}

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be created" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do
    context "when is successfully updated" do
      let(:user){ FactoryGirl.create :user }
      before(:each){ patch :update, {id: user.id, user:{ email: "new@email.com"}}, format: :json}

      it "renders the json representation for the updated user" do
        user_response = json_response
        expect(user_response[:email]).to eql "new@email.com"
      end

      it { should respond_with 200 }
    end

    context "when is not updated" do
      let(:user){ FactoryGirl.create(:user) }
      before(:each){ patch :update, {id: user.id, user:{ email: "bademail.com"}}, format: :json}

      it "renders an errors json" do
        user_response = json_response
        expect(user_response).to have_key(:errors)
      end

      it "renders the json errors on why the user could not be updated" do
        user_response = json_response
        expect(user_response[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }
    end
  end

  describe "DELETE #delete" do
    let(:user){ FactoryGirl.create :user }
    before(:each){ delete :destroy, { id: user.id}, format: :json }

    it { should respond_with 204 }
  end
end
