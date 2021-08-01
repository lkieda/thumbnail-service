# Thumbnail Service

This service takes URL of an image and displays its resized version. Request structure:

```
GET /thumbnail?url=<url>&width=<width>&height=<height>
```

For example we can take this picture: https://placekitten.com/200/300

And get its resized version: https://limitless-earth-78752.herokuapp.com/thumbnail?url=https://placekitten.com/200/300&width=150&height=400

## Running locally

The project uses Docker. To run it build the image:

```
docker-compose build
docker-compose run app rails db:create
```

To run the service:

```
docker-compose up app
```

Now, you should be able to hit the endpoint on localhost: http://localhost:3000/thumbnail?url=https://placekitten.com/200/300&width=150&height=400

Running tests:

```
docker-compose run app rspec
```

## Deployment

The service runs on Heroku, using following steps: https://devcenter.heroku.com/articles/getting-started-with-ruby
