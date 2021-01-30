FROM ruby:2.7.0


WORKDIR /retail-hub

# npm + yarn
RUN curl --silent --location https://deb.nodesource.com/setup_8.x | bash - && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get install -y nodejs && \
  npm install yarn -g

ADD . /retail-hub

ENV NODE_TLS_REJECT_UNAUTHORIZED 0

ARG NEXUS
ENV NEXUS=${NEXUS}

RUN bundle install --no-binstubs && \
    bin/rake assets:precompile NODE_ENV=production RAILS_ENV=production && \
    npm run apidoc

EXPOSE 8080

CMD ["bash", "/retail-hub/scripts/run_puma.sh"]
