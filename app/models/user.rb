class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pokers, dependent: :destroy
  
  has_many :game_room_users, dependent: :destroy
  has_many :game_rooms, through: :game_room_users
  has_many :created_game_rooms, class_name: "GameRoom", foreign_key: 'user_id'

  validates :first_name, :last_name, presence: true

  def name
    return unless self.first_name

    @name ||= "#{self.first_name} #{self.last_name}"
  end

  def has_already_voted?(issue)
    pokers.pluck(:issue_id).include?(issue.id)
  end

  def points_for(issue)
    pokers.find_by(issue: issue)&.story_points
  end
end
