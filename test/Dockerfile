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


RUN sed -i "23 a require_relative \'request_parameters.rb\'" /usr/local/bundle/gems/adal-1.0.0/lib/adal/client_assertion_certificate.rb
RUN cat /usr/local/bundle/gems/adal-1.0.0/lib/adal/client_assertion_certificate.rb

CMD ["rails", "s"]
#["bundle", "exec", "passenger", "start"]