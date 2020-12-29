FROM ruby

WORKDIR /app

ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock

RUN apt update 
RUN apt-get install -y nodejs
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - 
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list 
RUN apt-get update && apt-get install yarn
RUN apt-get install --no-install-recommends yarn
RUN gem install bundler
RUN bundle install