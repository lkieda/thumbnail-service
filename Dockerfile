FROM ruby:2.7.4-alpine

#RUN apt-get update && \
#    apt-get install -y --no-install-recommends \
RUN apk add --no-cache --update \
        postgresql-client postgresql-dev \
        tzdata \
        dumb-init \
        make cmake gcc g++

WORKDIR /code

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

ENTRYPOINT ["/usr/bin/dumb-init", "--", "/code/entrypoint.sh"]

CMD ["rails", "server", "--binding=0.0.0.0"]
