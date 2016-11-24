require 'rails_helper'

RSpec.describe RedirectionsController, type: :controller do

  describe "GET #redirect" do
    before do
      @user = User.create!(name: 'other user', password: 'asd', password_confirmation: 'asd')
      @short_url = ShortUrl.create!(original: 'http://facebook.com', converted: 'facebook')
    end

    it "redirects when short is correct" do
      get :redirect, params: {url: 'facebook'}
      expect(response.status).to eq(302)
    end

    it 'redirects to invalid_url when short_url is not correct' do
      get :redirect, params: {url: 'INVALID'}
      expect(response).to redirect_to(invalid_url_path)
    end
  end

end
