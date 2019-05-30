FROM node:12-alpine
WORKDIR /opt/
COPY . /opt/
RUN npm install
RUN npm build

CMD ["npm", "start"]
