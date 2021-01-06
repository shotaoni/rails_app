FROM ruby

ENV HOME="/app"
ENV LANG=C.UTF-8
ENV TZ=Asia/Tokyo

WORKDIR $HOME

RUN apt update 
RUN apt-get install -y nodejs

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - 
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list 
RUN apt-get update && apt-get install yarn
RUN apt-get install --no-install-recommends yarn

COPY Gemfile $HOME
COPY Gemfile.lock $HOME

RUN gem install bundler
RUN bundle install

COPY . $HOME

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]