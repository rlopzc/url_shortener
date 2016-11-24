require 'rails_helper'

RSpec.describe RedirectionsController, type: :controller do

  describe "GET #redirect" do
    it "returns http success" do
      get :redirect
      expect(response).to have_http_status(:success)
    end
  end

end
