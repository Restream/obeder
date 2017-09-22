FROM ruby:2.4.0

RUN apt-get update -qq && apt-get install -y build-essential postgresql libpq-dev curl redis-tools imagemagick
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs
RUN npm install -g yarn

RUN apt-get install locales
RUN echo 'ru_RU.UTF-8 UTF-8' >> /etc/locale.gen
RUN locale-gen ru_RU.UTF-8
RUN dpkg-reconfigure -fnoninteractive locales
ENV LC_ALL=ru_RU.utf8
ENV LANGUAGE=ru_RU.utf8
RUN update-locale LC_ALL="ru_RU.utf8" LANG="ru_RU.utf8" LANGUAGE="ru_RU"

WORKDIR /app

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --path /bundle_cache

COPY package.json package.json
COPY yarn.lock yarn.lock

ADD . /app

RUN yarn && yarn run build
RUN rails assets:precompile
