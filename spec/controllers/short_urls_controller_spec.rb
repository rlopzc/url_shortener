require 'rails_helper'

RSpec.describe Api::V1::ShortUrlsController, type: :controller do
  # This should return the minimal set of attributes required to create a valid
  # ShortUrl. As you add validations to ShortUrl, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {original: 'http://facebook.com', converted: 'facebook'}
  }

  let(:invalid_attributes) {
    {original: ''}
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # UsersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  context 'logged in user' do

    before do
      @user = User.create!(name: 'romario', password: 'asd', password_confirmation: 'asd')
      @request.env['HTTP_AUTHORIZATION'] = "Token token=#{@user.api_key}"
    end

    describe "GET #index" do
      it "assigns all short_urls as @short_urls" do
        short_url = @user.short_urls.create! valid_attributes
        get :index, params: {}
        expect(assigns(:short_urls)).to eq([short_url])
        expect(response.status).to eq(200)
      end
    end

    describe "GET #show" do
      it "assigns the requested short_url as @short_url" do
        short_url = @user.short_urls.create! valid_attributes
        get :show, params: {id: short_url.to_param}
        expect(assigns(:short_url)).to eq(short_url)
        expect(response.status).to eq(200)
      end
    end

    describe "POST #create" do
      context "with valid params" do
        it "creates a new ShortUrl" do
          expect {
            post :create, params: {short_url: valid_attributes}
          }.to change(ShortUrl, :count).by(1)
          expect(response.status).to eq(201)
        end

        it "assigns a newly created short_url as @short_url" do
          post :create, params: {short_url: valid_attributes}
          expect(assigns(:short_url)).to be_a(ShortUrl)
          expect(assigns(:short_url)).to be_persisted
          expect(response.status).to eq(201)
        end
      end

      context "with invalid params" do
        it "assigns a newly created but unsaved short_url as @short_url" do
          post :create, params: {short_url: invalid_attributes}
          expect(assigns(:short_url)).to be_a_new(ShortUrl)
          expect(response.status).to eq(422)
        end

        it "shows the errors" do
          post :create, params: {short_url: invalid_attributes}
          expect(response.status).to eq(422)
          expect(response.body).not_to eq(nil)
        end
      end
    end

    describe "DELETE #destroy" do
      it "destroys the requested short_url" do
        short_url = @user.short_urls.create! valid_attributes
        expect {
          delete :destroy, params: {id: short_url.to_param}
        }.to change(ShortUrl, :count).by(-1)
        expect(response.status).to eq(204)
      end
    end

    context "when user doesn't own the resource" do
      before do
        @other_user = User.create!(name: 'other user', password: 'asd', password_confirmation: 'asd')
      end

      it "can't destroy other users resources" do
        short_url = @other_user.short_urls.create! valid_attributes
        delete :destroy, params: {id: short_url.to_param}
        expect(response.status).to eq(403)
      end

      it "can't see other user resources" do
        short_url = @other_user.short_urls.create! valid_attributes
        get :show, params: {id: short_url.to_param}
        expect(response.status).to eq(403)
      end

      it "can't list index of other user resources" do
        short_url_1 = @other_user.short_urls.create!({original: 'asd', converted: 'dsadas'})
        short_url_2 = @other_user.short_urls.create! valid_attributes
        get :index, params: {}
        # logged in user is @user
        expect(response.body).not_to eq([short_url_1, short_url_2])
      end
    end
  end

  context 'when user is not logged in' do
    before do
      @user = User.create!(name: 'romario lopez', password: 'asd', password_confirmation: 'asd')
      @short_url = @user.short_urls.create! valid_attributes
    end

    it "can't index, show, update, or destroy any user resource" do
      get :index
      expect(response.status).to eq(401)

      get :show, params: {id: @short_url.id}
      expect(response.status).to eq(401)

      delete :destroy, params: {id: @short_url.id}
      expect(response.status).to eq(401)
    end
  end
end
