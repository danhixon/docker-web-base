# Use phusion/passenger-full as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/passenger-docker/blob/master/Changelog.md for
# a list of version numbers.
#FROM phusion/passenger-full:<VERSION>
# Or, instead of the 'full' variant, use one of these:
#FROM phusion/passenger-ruby18:<VERSION>
#FROM phusion/passenger-ruby19:<VERSION>
FROM phusion/passenger-ruby20
#FROM phusion/passenger-ruby21:<VERSION>
#FROM phusion/passenger-nodejs:<VERSION>
#FROM phusion/passenger-customizable:<VERSION>

# Set correct environment variables.
ENV HOME /root

# ...put your own build instructions here...
RUN apt-get -qq update
# libpq-dev is required for the pg gem,
# libxml2 libxslt-dev libxml2-dev are required by nokogiri,
# Need javascript engine for the asset pipeline
# Need git in order for capistrano to check out code from repo
# I like view files in vim:
RUN apt-get -yqq install curl build-essential libssl-dev zlib1g-dev libpq-dev libxml2 libxslt-dev libxml2-dev nodejs git-core vim && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "source /etc/container_environment.sh" >> /root/.bashrc

# Use baseimage-docker's init process.
CMD ["/sbin/my_init"]
