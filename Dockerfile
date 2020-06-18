FROM ruby:2.6.6

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        npm postgresql-client \
    && rm -rf /var/lib/apt/lists/*

# Copy application files and install the bundle
WORKDIR /usr/src/app
COPY Gemfile* ./
RUN bundle install
COPY . .

# Run asset pipeline.
RUN bundle exec rake assets:precompile

# use 0.0.0.0 to make port forwarding work in dev mode
# EXPOSE 3000
# CMD ["bundle", "exec", "rackup", "--port=3000", "--host=0.0.0.0"]
