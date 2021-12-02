class CreatePlayerGameDetails < ActiveRecord::Migration[6.0]
	def change
		create_table :player_game_details do |t|
			t.integer :player_id
			t.integer :team_id
			t.string :given_name
			t.string :position
			t.integer :games
			t.integer :games_started
			t.integer :at_bats 
			t.integer :runs 
			t.integer :hits
			t.integer :doubles 
			t.integer :triples 
			t.integer :home_runs 
			t.integer :rbi 
			t.integer :steals
			t.integer :caught_stealing 
			t.integer :sacrifice_hits 
			t.integer :sacrifice_flies 
			t.integer :errors 
			t.integer :pb 
			t.integer :walks
			t.integer :struck_out 
			t.integer :hit_by_pitch 
			t.timestamps
		end
	end
end