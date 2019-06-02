FROM node:12-alpine
WORKDIR /opt/
COPY . /opt/
RUN npm install

CMD ["npm", "start"]
