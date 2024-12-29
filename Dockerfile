# Use the official Ruby image
FROM ruby:3.2

# Install dependencies
RUN apt-get update -qq && apt-get install -y nodejs yarn

# Set the working directory
WORKDIR /app

# Install the required gems
COPY Gemfile Gemfile.lock ./
RUN bundle install

# Copy the application code into the container
COPY . .

# Precompile assets (optional, depending on your setup)
RUN bundle exec rake assets:precompile

# Set the environment variable for the PORT
ENV PORT 8080

# Expose the port the app will run on
EXPOSE 8080

# Start the Rails server
CMD ["bundle", "exec", "rails", "s", "-b", "0.0.0.0"]
