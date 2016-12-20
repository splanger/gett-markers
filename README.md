Gett Markers
===========
A simple web application which allows you to import drivers and their metrics and further view them on a map.


Requirements
============
- [ruby 2.3.x](https://www.ruby-lang.org/en/documentation/installation/)
- [rails 5.x](http://rubyonrails.org/)
- [sqlite3](https://sqlite.org/index.html)
- Some JavaScript runtime environment. For example (NodeJS)[https://nodejs.org/en/download/].

It is recommended to use (RVM)[https://rvm.io/rvm/install] with this project.


Quick Start
==========

First steps
-----------
    $ cd <PROJECT_PATH>
    $ bundle install    # Install all gems
    $ rails db:migrate  # Setup a development database
    $ rake gett:import  # Import seed data (drivers + metrics). This step might take a long time.
    $ rails s           # Start Rail's WEBrick web server
    
    # Open the application in a browser: http://127.0.0.1:3000


Further development
-----------
Several things might be enhanced in the feature:
 1. Time which 'gett:import' rake task takes might be significantly improved in several ways.
    For instance the task could be accomplished by using batch API of Metric model.
    Also, it is possible to just convert the JSON seed data file into *.sql file with appropriate INSERT
    statements. Then, just "recover" the database from that file.
 2. Angular can be used for front-end part
