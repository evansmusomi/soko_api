require 'rails_helper'

class Authentication < ActionController::Base
  include Authenticable
end

describe Authenticable, type: :controller do
  let(:authentication) { Authentication.new }

  describe "#current_user" do
    let(:user) { FactoryGirl.create :user }
    before do
      request.headers["Authorization"] = user.auth_token
      allow(authentication).to receive(:request).and_return(request)
    end

    it "returns the user from the authorization header" do
      expect(authentication.current_user.auth_token).to eql user.auth_token
    end
  end

  describe "#authenticate_with_token" do
    let(:user){ FactoryGirl.create :user }
    subject { authentication }

    before do
      allow(authentication).to receive(:current_user).and_return(nil)
      allow(response).to receive(:response_code).and_return(401)
      allow(response).to receive(:body).and_return({"errors" => "Not authenticated"}.to_json)
      allow(authentication).to receive(:response).and_return(response)
    end

    it "renders a json error message" do
      expect(json_response[:errors]).to eql "Not authenticated"
    end

    it { should respond_with 401 }
  end
end
