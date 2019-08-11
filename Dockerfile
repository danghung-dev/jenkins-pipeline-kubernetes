FROM node:10.15.3-alpine
WORKDIR /usr/src/app

COPY ./package.json ./yarn.lock ./

RUN npm i
# Bundle app source
COPY ./ .

CMD [ "node", "index.js" ]