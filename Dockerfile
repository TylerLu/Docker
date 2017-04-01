FROM ruby:2.3
MAINTAINER Tyler Lu <tyler.lu@canviz.com>
RUN apt-get update -qq && apt-get install -y \
    nodejs  \
    unzip --no-install-recommends \
    libmysqlclient-dev

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

ENV RAILS_ENV production
ENV SECRET_KEY_BASE ae3672e1df60753ca80d3e18d8f839c9753cd2ee60d466e1b6e9a13e8b4b10596846cdf077e17854690e700081fbe03e94c8b47027fda17feb8a53b4a1204f30

# Splash site
COPY splashsite.zip /tmp
RUN unzip -q /tmp/splashsite.zip -d /opt/splash 
RUN cd /opt/splash/splash; bundle install

COPY cmd.sh /bin/
RUN chmod 755 /bin/cmd.sh
CMD ["/bin/cmd.sh"]