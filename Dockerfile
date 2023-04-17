# Use an official Ruby runtime as a parent image
FROM ruby:3.1.2
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
# Install dependencies
RUN apt-get update -qq && \
    apt-get install -y  build-essential \
    libpq-dev \
    nodejs \
    sqlite3 \
    yarn \
    && apt-get clean && rm -rf /var/lib/apt/lists/*  /tmp/* /var/tmp/*
# Set the working directory to /app
WORKDIR /conveyor_system
# Copy the Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install Ruby dependencies
RUN gem install bundler && bundle install --jobs 20 --retry 5

# Copy the Rails application
COPY . ./
# Set up database
##RUN rails db:create && rails db:migrate && db:seed
# Expose port 3000 for the Rails server
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
