require 'spec_helper'

feature 'Starting a new game' do
  scenario 'I am asked to enter my name' do
    visit '/'
    click_button 'New Game'
    expect(page).to have_content "What's your name?"
  end

  scenario 'entering my name takes me to a new page containing a greeting' do
    visit '/new_game'
    fill_in('name', :with => 'Archie')
    click_button('Submit')
    expect(page).to have_content "Greetings Archie!"
  end

  scenario 'not entering a name will ask for a name' do
    visit '/new_game'
    fill_in('name', :with => '')
    click_button('Submit')
    expect(page).to have_content "Please enter a name!"
  end

  scenario 'pressing start game button takes me to board' do
    visit '/greetings'
    click_button("Start Game")
    expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#c6e2ff; border-radius: 15px']", count: 100)
  end

  scenario 'expect placing a destroyer to show up on the board' do
    visit '/game_board'
    $board = Board.new(Cell)
    fill_in('coordinates_1', :with => 'A1')
    click_button('Place Destroyer')
    expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#c6e2ff; border-radius: 15px']", count: 97)
    expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#33cc33; border-radius: 15px']", count: 3)
  end

  scenario 'expect placing a battleship to show up on the board' do
    visit '/game_board'
    $board = Board.new(Cell)
    fill_in('coordinates_2', :with => 'A1')
    click_button('Place Battleship')
    expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#c6e2ff; border-radius: 15px']", count: 96)
    expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#33cc33; border-radius: 15px']", count: 4)
  end

  scenario 'expect placing aan aircraft-carrier to show up on the board' do
    visit '/game_board'
    $board = Board.new(Cell)
    fill_in('coordinates_3', :with => 'A1')
    click_button('Place Aircraft-Carrier')
    expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#c6e2ff; border-radius: 15px']", count: 95)
    expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#33cc33; border-radius: 15px']", count: 5)
  end

  scenario 'expect placing a patrol boat to show up on the board' do
    visit '/game_board'
    $board = Board.new(Cell)
    fill_in('coordinates_4', :with => 'A1')
    click_button('Place Patrol Boat')
    expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#c6e2ff; border-radius: 15px']", count: 98)
    expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#33cc33; border-radius: 15px']", count: 2)
  end

  scenario 'expect placing a submarine to show up on the board' do
    visit '/game_board'
    $board = Board.new(Cell)
    fill_in('coordinates_5', :with => 'A1')
    click_button('Place Submarine')
    expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#c6e2ff; border-radius: 15px']", count: 97)
    expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#33cc33; border-radius: 15px']", count: 3)
  end

  scenario 'expect placing all five ships to show up on the board' do
    visit '/game_board'
    $board = Board.new(Cell)
    fill_in('coordinates_1', :with => 'A1')
    click_button('Place Destroyer')
    fill_in('coordinates_2', :with => 'B1')
    click_button('Place Battleship')
    fill_in('coordinates_3', :with => 'C1')
    click_button('Place Aircraft-Carrier')
    fill_in('coordinates_4', :with => 'D1')
    click_button('Place Patrol Boat')
    fill_in('coordinates_5', :with => 'E1')
    click_button('Place Submarine')
    expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#c6e2ff; border-radius: 15px']", count: 83)
    expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#33cc33; border-radius: 15px']", count: 17)
  end

  scenario 'expect placing a destroyer to show up on the board at the right place' do
    visit '/game_board'
    $board = Board.new(Cell)
    fill_in('coordinates_1', :with => 'A1')
    choose('destroyer_v')
    click_button('Place Destroyer')
    expect(page).to have_selector("div#A1.ship")   #[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#33cc33; border-radius: 15px']")
    # expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#c6e2ff; border-radius: 15px']", count: 97)
    # expect(page).to have_css("div[style='display: inline-block; border: 1px solid white; height:30px; width:30px; background-color:#33cc33; border-radius: 15px']", count: 3)
  end



end
