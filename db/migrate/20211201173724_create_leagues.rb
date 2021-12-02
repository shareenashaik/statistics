class CreateLeagues < ActiveRecord::Migration[6.0]
	def change
		create_table :leagues do |t|
			t.string :name
			t.integer :year
			t.string :division_name
			t.timestamps
		end
	end
end
