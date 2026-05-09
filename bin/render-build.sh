#!/usr/bin/env bash
# Render.com 用ビルドスクリプト
set -o errexit

bundle install
bundle exec rails assets:precompile
bundle exec rails assets:clean
bundle exec rails db:migrate
