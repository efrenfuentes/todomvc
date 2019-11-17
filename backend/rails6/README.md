Rails 6 Backend
===============

Install dependencies:

    bundle install

To run the tests:

    RAILS_ENV=test bundle exec rails db:migrate
    RAILS_ENV=test bundle exec rspec


To run the API:

    bundle exec rails db:migrate
    bundle exec rails s
