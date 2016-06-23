#!/bin/bash

if (($#)); then
  RSPEC_ARGS=("$@")
else
  RSPEC_ARGS=(--pattern 'spec/**/*-spec.rb')
fi

PROJECT_NAME_ENV=test bundle exec rspec "${RSPEC_ARGS[@]}"
