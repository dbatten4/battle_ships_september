class Board
	attr_reader :grid

	def initialize(cell)
		@grid = {}
		[*"A".."J"].each do |l|
			[*1..10].each do |n|
				@grid["#{l}#{n}".to_sym] = cell.new
				@grid["#{l}#{n}".to_sym].content = Water.new
			end
		end
	end

	def place(ship, coord, orientation = :horizontally)
		coords = [coord]
		(ship.size - 1).times{coords << next_coord(coords.last, orientation)}
		put_on_grid_if_possible(coords, ship)
	end

	def rand_place(ship)
    orientation = [:horizontally,:vertically][rand(0..1)]
    coord = "#{[*'A'..'J'].sample}#{[*1..10].sample}".to_sym
    begin
       place(ship,coord,orientation)
    rescue
       rand_place(ship)
    end
  end

	def floating_ships?
		ships.any?(&:floating?)
	end

	def shoot_at(coordinate)
		raise "You cannot hit the same square twice" if  grid[coordinate].hit?
		grid[coordinate].shoot
	end

	def shoot_at_random
    coordinate = "#{[*'A'..'J'].sample}#{[*1..10].sample}".to_sym
    begin
       shoot_at(coordinate)
    rescue
       shoot_at_random
    end
  end

	def ships
		grid.values.select{|cell|is_a_ship?(cell)}.map(&:content).uniq
	end

	def ships_count
		ships.count
	end

	def print_board
		printed_board = "<div style='width: 330px; float:left;'>"
		[*"A".."J"].each do |l|
			[*1..10].each do |n|
				if @grid["#{l}#{n}".to_sym].content.is_a? Water
					if @grid["#{l}#{n}".to_sym].hit == true
						printed_board += "<div style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#bfc4bf; border-radius: 15px'> </div>"
					else
						printed_board += "<div style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#c6e2ff; border-radius: 15px'> </div>"
					end
				else
					if @grid["#{l}#{n}".to_sym].hit == true
						printed_board += "<div style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#e62e00; border-radius: 15px'> </div>"
					else
						printed_board += "<div style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#33cc33; border-radius: 15px'> </div>"
					end
				end
			end
		end
		printed_board += "</div>"
		printed_board
	end

	def print_opponent_board
		printed_board = "<div style='width: 330px; float:left;'>"
		[*"A".."J"].each do |l|
			[*1..10].each do |n|
				if @grid["#{l}#{n}".to_sym].content.is_a? Water
					if @grid["#{l}#{n}".to_sym].hit == true
						printed_board += "<div style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#bfc4bf; border-radius: 15px'> </div>"
					else
						printed_board += "<div style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#c6e2ff; border-radius: 15px'> </div>"
					end
				else
					if @grid["#{l}#{n}".to_sym].hit == true
						printed_board += "<div style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#e62e00; border-radius: 15px'> </div>"
					else
						printed_board += "<div style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#c6e2ff; border-radius: 15px'> </div>"
					end
				end
			end
		end
		printed_board += "</div>"
		printed_board
	end

	def won?
		self.ships.each do |ship|
			return false if ship.sunk? == false
		end
		return true
	end


private

 	def next_coord(coord, orientation)
		orientation == :vertically ? next_vertical(coord) : coord.next
	end

	def next_vertical(coord)
		coord.to_s.reverse.next.reverse.to_sym
	end

	def is_a_ship?(cell)
		cell.content.respond_to?(:sunk?)
	end

	def any_coord_not_on_grid?(coords)
		(grid.keys & coords) != coords
	end

	def any_coord_is_already_a_ship?(coords)
		coords.any?{|coord| is_a_ship?(grid[coord])}
	end

	def raise_errors_if_cant_place_ship(coords)
		raise "You cannot place a ship outside of the grid" if any_coord_not_on_grid?(coords)
		raise "You cannot place a ship on another ship" if any_coord_is_already_a_ship?(coords)
	end

	def put_on_grid_if_possible(coords, ship)
		raise_errors_if_cant_place_ship(coords)
		coords.each{|coord|grid[coord].content = ship}
	end

end
