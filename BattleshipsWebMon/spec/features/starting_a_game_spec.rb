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
    expect(page).to have_css("#c6e2ff")
  end

  # scenario 'can add ships to the board' do
  #   visit '/game_board?coordinates_1=A1&orientation_1=horizontally'
  #   # fill_in('coordinates_1', :with => 'A1')
  #   # within("#destoyer_radio") do
  #   # choose('Horizontally')
  #     # click_button("Place")
  #   # end
  #   expect(page).to have_css("#ffff32")
  # end

end
