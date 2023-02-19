class GameRoom < ApplicationRecord
  resourcify
  
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  belongs_to :current_issue, class_name: "Issue", optional: true
  
  has_many :issues, dependent: :destroy
  has_many :pokers, through: :issues, dependent: :destroy
  has_many :game_room_users, dependent: :destroy
  has_many :users, through: :game_room_users

  after_create_commit :create_game_room_user
  before_create :set_token
  after_create :set_owner_role

  after_update_commit :broadcast_current_issue, if: :saved_change_to_current_issue_id?

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

    def broadcast_current_issue
      users.each do |user|
        Current.user = user
        broadcast_update_to(
          self,
          Current.user, 
          target: "game_room", partial: 'game_rooms/game_room',
          locals: { 
            game_room: self,
            current_issue: current_issue,
            poker: Poker.find_or_initialize_by(issue: current_issue, user: Current.user),
            issue: current_issue,
            issues: issues
          }
        )
      end
    end

    def set_owner_role
      creator.add_role(:owner, self)
    end
end
