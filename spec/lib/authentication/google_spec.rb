# frozen_string_literal: true

require 'rails_helper'

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