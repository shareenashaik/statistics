class Team < ApplicationRecord

	belongs_to :league
	has_many :player_game_details
	has_many :players, through: :player_game_details
end
