FROM ruby:2.3
RUN apt-get update -qq && apt-get install -y nodejs unzip --no-install-recommends

# Rollback bundler version for deployment reasons (14 had a breaking change for us)
RUN  gem uninstall -i /usr/local/lib/ruby/gems/2.3.0 bundler
RUN gem install bundler --version "=1.13.6"

# Install passenger
RUN gem install rubygems-bundler
RUN gem regenerate_binstubs 
RUN gem install --no-user-install passenger

# Logs will be sent to /usr/local/passenger/logs which will show up in LogFiles for user
RUN mkdir -p /usr/local/passenger
RUN ln -s /home/LogFiles /usr/local/passenger/logs

RUN mkdir -p /opt/splash
ADD . /opt/splash 

RUN cd /opt/splash/; bundle install
WORKDIR /opt/splash/
CMD ["rails", "s"]
#["bundle", "exec", "passenger", "start"]