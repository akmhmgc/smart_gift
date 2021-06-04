FROM ruby:2.6.6
RUN curl -sL https://deb.nodesource.com/setup_lts.x | bash - && \
apt-get install nodejs -y

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - \
    && echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list \
    && apt-get update && apt-get install -y yarn
RUN mkdir /smart_gift
WORKDIR /smart_gift
COPY Gemfile /smart_gift/Gemfile
COPY Gemfile.lock /smart_gift/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /smart_gift

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]