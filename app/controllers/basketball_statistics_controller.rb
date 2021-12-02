class BasketballStatisticsController < ApplicationController

	def index
		@player_details = PlayerGameDetail.includes([:team, :player])
	end
end
