# frozen_string_literal: true

class AddOwnerRoleToAllCreator < ActiveRecord::Migration[7.0]
  def up
    GameRoom.find_each do |game_room|
      game_room.creator&.add_role(:owner, game_room)
    end

    AddOwnerRoleToAllCreatorVerifier.new.verify
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end

class AddOwnerRoleToAllCreatorVerifier
  def verify
    GameRoom.find_each do |game_room|
      next unless game_room.creator

      raise "GameRoom #{game_room.id} has no owner role" unless game_room.creator.has_role?(:owner, game_room)
    end
  end
end
