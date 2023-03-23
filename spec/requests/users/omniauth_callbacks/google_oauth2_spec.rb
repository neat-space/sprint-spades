require 'rails_helper'

RSpec.describe "Users::OmniauthCallbacksController#google_oauth2", type: :request do
  let(:auth_hash) do
    {
      provider: 'google_oauth2',
      uid: '123456',
      info: {
        email: 'test@example.com',
        first_name: 'Test',
        last_name: 'User'
      },
      credentials: {
        token: 'token123',
        expires_at: Time.now + 1.week
      }
    }
  end

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(auth_hash)
  end

  context 'when user is already registered' do
    let!(:user) { create(:user, email: 'test@example.com') }

    before do
      get '/users/auth/google_oauth2/callback'
    end

    it 'signs in the user' do
      expect(controller.current_user).to eq user
    end

    it 'sets a flash notice message' do
      expect(flash[:notice]).to eq 'Successfully authenticated from Google account.'
    end

    it 'redirects the user to the root path' do
      expect(response).to redirect_to(root_path)
    end
  end

  context 'when user is not registered' do
    let(:user) { build(:user) }

    before do
      allow(Authentication::Google).to receive(:new).and_return(double(user!: user))
      get '/users/auth/google_oauth2/callback'
    end

    it 'sets a flash error message' do
      expect(flash[:error]).to eq 'There was a problem signing you in through Google. Please register or try signing in later.'
    end

    it 'redirects the user to the new user registration page' do
      expect(response).to redirect_to(new_user_registration_path)
    end
  end
end
