FROM ruby:2.6.6
ENV LANG C.UTF-8
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
apt-get install nodejs -y

RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
apt-get update && apt-get install -y yarn

RUN mkdir /smart_gift
WORKDIR /smart_gift

ADD Gemfile /smart_gift/Gemfile
ADD Gemfile.lock /smart_gift/Gemfile.lock

RUN gem install bundler:2.1.4
RUN bundle lock --add-platform mingw, mswin, x64_mingw, jruby
RUN bundle install

ADD . /smart_gift

RUN mkdir -p tmp/sockets
VOLUME /smart_gift/public
VOLUME /smart_gift/tmp

RUN yarn install --check-files

# image作成時に実行するとタイムアウトする
# RUN SECRET_KEY_BASE=placeholder bundle exec rails assets:precompile

RUN SECRET_KEY_BASE=placeholder WEBPACKER_PRECOMPILE=false bundle exec rails assets:precompile
RUN bin/webpack