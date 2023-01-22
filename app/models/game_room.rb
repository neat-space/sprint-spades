class GameRoom < ApplicationRecord
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  belongs_to :current_issue, class_name: "Issue", optional: true
  
  has_many :issues, dependent: :destroy
  has_many :pokers, through: :issues, dependent: :destroy
  has_many :game_room_users, dependent: :destroy
  has_many :users, through: :game_room_users

  after_create_commit :create_game_room_user
  before_create :set_token

  private

    def create_game_room_user
      GameRoomUser.create!(game_room: self, user: self.creator)
    end

    def set_token
      self.token = generate_token
    end

    def generate_token
      loop do
        token = SecureRandom.hex
        break token unless GameRoom.where(token: token).exists?
      end
    end
end
