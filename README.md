# game_store_project
## Running

after creating database named 'gamestore',
run seed.rb
in terminal
psql -d gamestore -f gamestore.sql

run app.rb file.

For Ubuntu: in db/sql_runner.rb file set host: '' (to empty string instead of localhost).

## Technologies used:
Sinatra, PostgreSQL and Minitest for running test.

![alt text](https://github.com/errne/game_store_project/blob/master/screenshots/Screen%20Shot%202018-11-14%20at%2015.57.14.png)

## Key Features:

* maintaining inventory (of pc games) database
* users are able to add and edit games, publishers, developers, tags.
* sort games by name, price, stock_count, year published
* check total inventory value and possible profits
