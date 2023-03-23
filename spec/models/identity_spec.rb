# == Schema Information
#
# Table name: identities
#
#  id         :bigint           not null, primary key
#  provider   :string
#  uid        :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint           not null
#
# Indexes
#
#  index_identities_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Identity, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
  end

  describe 'scopes' do
    describe '.google_auth' do
      let!(:identity) { create(:identity, provider: 'google_oauth2') }
      let!(:identity2) { create(:identity, provider: 'facebook') }

      it 'returns the identity with google oauth2 provider' do
        expect(Identity.google_auth).to include(identity)
      end

      it 'does not return the identity with facebook provider' do
        expect(Identity.google_auth).not_to include(identity2)
      end
    end
  end
end
