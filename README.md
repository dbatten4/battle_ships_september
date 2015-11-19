# Battleships Web

This is my second attempt at this challenge

This project serves as an introduction to the ruby web framework Sinatra. 

The game is ready to play when theres are two players initialized with a board each and each board has 5 ships placed. 

By default it is player1's go first and after each shot it will switch the turns until there is a winner. 

A game_setup.rb file has been added which sets up the game to a ready state placeing each ship from colums A through to E vertically. 

## Getting started

Run 
`git clone https://github.com/dbatten4/battleships-web.git`
to clone the repo and 
`bundle`
to install the gems and dependencies in the Gemfile after running
`gem install bundle`
to install the bundle gem

## Usage

Run 
`rackup`
to start the web server and navigate to `http://localhost:9292/`

## Running tests

Run 
`rspec`
to run the tests
