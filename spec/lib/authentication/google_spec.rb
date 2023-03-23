# frozen_string_literal: true

require 'rails_helper'

# module Authentication
#   class Google
#     PROVIDER = "google_oauth2"

#     def initialize(user_data)
#       @user_data = user_data
#     end

#     def user!
#       return if @user_data.blank? || google_id.blank?

#       Identity.google_auth.where(uid: google_id)&.first&.user || create_user!
#     end

#     private
#       def create_user!
#         user = User.find_by_email(email)
#         if user.present?
#           user.identities.find_or_create_by(provider: PROVIDER, uid: google_id)
#         else
#           user_first_name = first_name || email.split("@").first
#           user = User.new(
#             email: email,
#             first_name: user_first_name,
#             last_name: last_name,
#             password: Devise.friendly_token[0, 20]
#           )
#           user.save
#           user.identities.create(provider: PROVIDER, uid: google_id)
#         end
#         user
#       end

#       def email
#         @user_data.info.email
#       end

#       def first_name
#         @user_data.info.first_name
#       end

#       def last_name
#         @user_data.info.last_name
#       end

#       def google_id
#         @user_data.uid
#       end
#   end
# end

RSpec.describe Authentication::Google do
  describe "#user!" do
    let(:subject) { described_class.new(user_data) }

    context "when user data is blank" do
      let(:user_data) { double("User data", info: double("Info", email: nil, first_name: nil, last_name: nil), uid: nil) }

      it "does not create a user" do
        expect { subject.user! }.not_to change(User, :count)
      end

      it "returns nil" do
        expect(subject.user!).to be_nil
      end
    end

    context "when user data is not blank" do
      let(:google_id) { "123" }
      let(:user_data) { double("User data", info: double("Info", email: "test@example.com", first_name: "Test", last_name: "User"), uid: google_id) }

      context "when user already exists" do
        let!(:user) { create(:user, email: "test@example.com") }
        let(:identity) { create(:identity, provider: Authentication::Google::PROVIDER, uid: google_id) }


        it "does not create a new user" do
          expect { subject.user! }.not_to change(User, :count)
        end

        it "creates a new identity if one does not exist" do
          expect { subject.user! }.to change(Identity, :count).by(1)
        end

        it "returns the user" do
          expect(subject.user!).to eq(user)
        end
      end

      context "when user does not exist" do
        let(:identity) { build(:identity, provider: Authentication::Google::PROVIDER, uid: google_id) }

        before do
          allow(Identity).to receive(:new).and_return(identity)
        end

        it "creates a new user" do
          expect { subject.user! }.to change(User, :count).by(1)
        end

        it "sets the user's email, first name, and last name" do
          user = subject.user!
          expect(user.email).to eq("test@example.com")
          expect(user.first_name).to eq("Test")
          expect(user.last_name).to eq("User")
        end

        it "sets the user's password" do
          user = subject.user!
          expect(user.password).not_to be_blank
        end

        it "associates the user with the identity" do
          expect(subject.user!.identities).to include(identity)
        end

        it "returns the user" do
          expect(subject.user!).to eq(User.last)
        end
      end
    end
  end
end