class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  scope :recent, -> { order(created_at: :desc) }
end
