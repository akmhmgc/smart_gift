FROM ruby:2.6.6
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update -qq \
    && apt-get install -y yarn \
    && mkdir /smart_gift \
    && apt-get install -y nodejs npm && npm install n -g && n 12.13.0
WORKDIR /smart_gift
COPY Gemfile /smart_gift/Gemfile
COPY Gemfile.lock /smart_gift/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /smart_gift

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
RUN npm rebuild node-sass
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]