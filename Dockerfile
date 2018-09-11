# From https://itnext.io/docker-rails-puma-nginx-postgres-999cd8866b18
FROM ruby:2.5.1

#RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# https://github.com/nodesource/distributions#installation-instructions
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
        && apt-get install -y nodejs

RUN mkdir /railsApp

WORKDIR /railsApp

COPY Gemfile /railsApp/Gemfile

COPY Gemfile.lock /railsApp/Gemfile.lock

RUN bundle install

COPY . /railsApp

RUN rake db:migrate

#CMD ["rails", "server", "--binding", "0.0.0.0"]