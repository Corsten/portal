FROM ruby:2.4.1

RUN printf "deb http://archive.debian.org/debian/ jessie main\ndeb-src http://archive.debian.org/debian/ jessie main\ndeb http://security.debian.org jessie/updates main\ndeb-src http://security.debian.org jessie/updates main" > /etc/apt/sources.list
RUN apt-get update -qq && apt-get install -y build-essential sqlite3 libsqlite3-dev
RUN gem install mailcatcher -v 0.6.5 --no-ri --no-rdoc

# smtp port
EXPOSE 1025

# webserver port
EXPOSE 1080

CMD mailcatcher -f --ip=0.0.0.0