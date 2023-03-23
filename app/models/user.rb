# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :pokers, dependent: :destroy
  has_many :identities, dependent: :delete_all
  has_many :game_room_users, dependent: :destroy
  has_many :game_rooms, through: :game_room_users
  has_many :created_game_rooms, class_name: "GameRoom", foreign_key: 'user_id'
  rolify after_add: :broadcast_role_update, after_remove: :broadcast_role_update

  validates :first_name, :last_name, presence: true
  def name
    return unless first_name

    @name ||= "#{first_name} #{last_name}"
  end

  def already_voted?(issue)
    pokers.pluck(:issue_id).include?(issue.id)
  end

  def points_for(issue)
    pokers.find_by(issue:)&.story_points
  end

  private

    def broadcast_role_update(role)
      Current.user = self
      game_room = role.resource
      broadcast_update_to(
        game_room,
        Current.user, 
        target: "game_room", partial: 'game_rooms/game_room',
        locals: { 
          game_room: game_room,
          current_issue: game_room.current_issue,
          poker: Poker.find_or_initialize_by(issue: game_room.current_issue, user: self),
          issue: game_room.current_issue,
          issues: game_room.issues
        }
      )
    end

end
