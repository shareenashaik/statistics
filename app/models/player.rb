class Player < ApplicationRecord

	has_many :player_game_details
	has_many :teams, through: :player_game_details

	def self.test
		uri = URI.parse("http://www.cafeconleche.org/examples/baseball/1998statistics.xml")
		http = Net::HTTP.new(uri.host, uri.port)
		data = http.get(uri.request_uri).body
		xml = Nokogiri::XML(data)
		year = xml.search("YEAR").first.text
		xml.xpath("//LEAGUE").each do |league|
			league.xpath("//DIVISION").each do |division|
				binding.pry
				league = League.create_or_find_by(name: league.search("LEAGUE_NAME").first.text, division_name: division.search("DIVISION_NAME").first.text, year: year)
				division.xpath("//TEAM").each do |team_x|
					city = City.create_or_find_by(name: team_x.search("TEAM_CITY").first.text)
					team = Team.create_or_find_by(name: team_x.search("TEAM_NAME").first.text, league_id: league.id, city_id: city.id)
					team_x.xpath("//PLAYER").each do |player_x|
						player = Player.create_or_find_by(name: player_x.search("SURNAME").first.text)
						p_s = PlayerGameDetail.new(player_id: player.id, team_id: team.id)
						["GIVEN_NAME", "POSITION", "GAMES", "GAMES_STARTED", "AT_BATS", "RUNS", "HITS", "DOUBLES", "TRIPLES", "HOME_RUNS", "RBI", "STEALS", "CAUGHT_STEALING", "SACRIFICE_HITS", "SACRIFICE_FLIES", "ERRORS", "PB", "WALKS", "STRUCK_OUT", "HIT_BY_PITCH"].each do |attr|
							val = player_x.search(attr).first.text rescue nil
							if val.present?
								p_s.send("#{attr.downcase}=", player_x.search(attr).first.text)
							end
						end
						p_s.save!
					end
				end
			end
		end
	end
end
