# == Schema Information
#
# Table name: pokers
#
#  id           :bigint           not null, primary key
#  remarks      :text
#  story_points :integer          not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  issue_id     :bigint           not null
#  user_id      :bigint           not null
#
# Indexes
#
#  index_pokers_on_issue_id              (issue_id)
#  index_pokers_on_user_id               (user_id)
#  index_pokers_on_user_id_and_issue_id  (user_id,issue_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (issue_id => issues.id)
#  fk_rails_...  (user_id => users.id)
#

FactoryBot.define do
  factory :poker do
    story_points { 1 }
    remarks { Faker::Lorem.sentence }
    issue
    user
  end
end
