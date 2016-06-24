require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe "POST #create" do
    let(:user){ FactoryGirl.create :user }

    context "when the credentials are correct" do
      let(:credentials){ {email: user.email, password: user.password} }
      before(:each){ post :create, { session: credentials}}

      it "returns the user record matching the given credentials" do
         user.reload
         expect(json_response[:auth_token]).to eql user.auth_token
      end

      it { should respond_with 200 }
    end

    context "when the credentials are incorrect" do
      let(:credentials){ {email: user.email, password: "invalidpassword"}}
      before(:each){ post :create, { session: credentials}}

      it "returns a json with an error" do
        expect(json_response[:errors]).to eql "Invalid email or password"
      end

      it { should respond_with 422 }
    end
  end

  def "DELETE #destroy" do
    let(:user){ FactoryGirl.create :user }
    before(:each) do
      sign_in user, store: false
      delete :destroy, id: user.auth_token
    end

    it { should respond_with 204 }
  end
end
