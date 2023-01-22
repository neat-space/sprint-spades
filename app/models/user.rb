class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :pokers, dependent: :destroy
  
  has_many :game_room_users, dependent: :destroy
  has_many :game_rooms, through: :game_room_users
end
