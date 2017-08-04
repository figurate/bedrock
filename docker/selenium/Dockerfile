FROM node

RUN npm install --save-dev protractor cucumber protractor-cucumber-framework

WORKDIR /e2e

ADD protractor.conf.js ./
ADD tests tests

CMD ["/node_modules/.bin/protractor", "protractor.conf.js"]
