FROM ruby:2.5
WORKDIR /opt/
COPY . /opt/
RUN uninstall bundler
RUN gem install bundler -v2.0.1
RUN bundle install

CMD ["rake", "run"]
