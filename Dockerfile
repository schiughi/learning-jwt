FROM ruby:2.4.1
ENV APP_HOME /myapp
ENV LANG C.UTF-8

# シェルスクリプトとしてbashを利用
RUN rm /bin/sh && ln -s /bin/bash /bin/sh
# 必要なライブラリインストール
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev
# yarnパッケージ管理ツールインストール
RUN apt-get update && apt-get install -y curl apt-transport-https wget && \
  curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
  apt-get update && apt-get install -y yarn
# Node.jsをインストール
RUN curl -sL https://deb.nodesource.com/setup_8.x | bash - && \
  apt-get install nodejs
# gem:Rails-erd用 グラフ描画ツール
RUN apt-get update && apt-get install -y graphviz postgresql
# ワークディレクトリ設定
RUN mkdir ${APP_HOME}
WORKDIR ${APP_HOME}
ADD Gemfile ${APP_HOME}/Gemfile
ADD Gemfile.lock ${APP_HOME}/Gemfile.lock
RUN bundle install
ADD . ${APP_HOME}
