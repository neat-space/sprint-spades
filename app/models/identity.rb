class Identity < ApplicationRecord
  belongs_to :user

  scope :google_auth, -> { where(provider: "google_oauth2") }
end
