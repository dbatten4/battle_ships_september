require 'sinatra/base'
require_relative '../game_setup'

class BattleshipsWeb < Sinatra::Base
  enable :sessions
  get '/' do
    erb :index
  end

  get '/newGame' do
    erb :newGame
  end

  get '/greetings' do
    @visitor = params[:name]
      $board = Board.new(Cell)
    erb :greetings

  end

  get '/game_board' do

    @destroyer = Ship.destroyer
    coordinates_1 = params[:coordinates_1].to_sym if params[:coordinates_1]
    orientation_1 = params[:orientation_1].to_sym if params[:orientation_1]
      if coordinates_1 && orientation_1
        $board.place(@destroyer, coordinates_1, orientation_1)
      end
    @battleship = Ship.battleship
    coordinates_2 = params[:coordinates_2].to_sym if params[:coordinates_2]
    orientation_2 = params[:orientation_2].to_sym if params[:orientation_2]
      if coordinates_2 && orientation_2
        $board.place(@battleship, coordinates_2, orientation_2)
      end
    erb :game_board
  end

set :views, proc { File.join(root, '..', 'views') }

  # start the server if ruby file executed directly
  run! if app_file == $0
end
