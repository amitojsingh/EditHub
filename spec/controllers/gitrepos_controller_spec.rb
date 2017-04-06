require 'rails_helper'

RSpec.describe GitreposController, type: :controller do

  describe "GET #newrepo" do
    it "returns http success" do
      get :newrepo
      expect(response).to have_http_status(:success)
    end
  end

end
