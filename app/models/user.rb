class User < ApplicationRecord
  rolify
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
end
