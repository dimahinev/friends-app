# We're going to use Ruby 3.1.3 as our base image
FROM ruby:3.1.3

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Set an environment variable where the Rails app is installed to inside of Docker image:
ENV RAILS_ROOT /var/www/app
RUN mkdir -p $RAILS_ROOT 

# Set working directory, where the commands will be ran:
WORKDIR $RAILS_ROOT

# Gems:
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --jobs 20 --retry 5 

# Copy the main application.
COPY . .

# Expose port 3000 to the Docker host, so we can access it from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also tells the Rails dev server to bind to all interfaces by default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
