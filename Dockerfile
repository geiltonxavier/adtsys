FROM ruby:2.3
MAINTAINER Geilton Xavier <geilton@live.com>

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs



RUN mkdir -p /adtsys
WORKDIR /adtsys

# Caching the gems
COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copying the application
COPY . ./

RUN rake db:migrate
RUN rake db:seed


# Exposing the port 3000 to the host
EXPOSE 3000

# Adding the common entrypoint for executing tasks
ENTRYPOINT ["bundle", "exec"]

# Starting the application
CMD ["rails", "server", "-b", "0.0.0.0"]
